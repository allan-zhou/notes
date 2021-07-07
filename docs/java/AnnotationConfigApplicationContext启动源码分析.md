# AnnotationConfigApplicationContext

客户端调用代码：
```java
AnnotationConfigApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
```

```java
    // 获取BeanDefinition, 刷新上下文
	/**
	 * Create a new AnnotationConfigApplicationContext, deriving bean definitions
	 * from the given component classes and automatically refreshing the context.
	 * @param componentClasses one or more component classes &mdash; for example,
	 * {@link Configuration @Configuration} classes
	 */
	public AnnotationConfigApplicationContext(Class<?>... componentClasses) {
		// 初始化reader、scanner
        this();
        // 1、this.reader.register(componentClasses);
        // 2、this.scanner.scan(basePackages);
        // 得到 Set<BeanDefinitionHolder>
		register(componentClasses);
        // 刷新
		refresh();
	}
```

```java
	private final AnnotatedBeanDefinitionReader reader;
	private final ClassPathBeanDefinitionScanner scanner;

	public AnnotationConfigApplicationContext() {
        // 通过给定的BeanDefinitionRegistry创建，
        // 核心方法 doRegisterBean()，得到 BeanDefinitionHolder
		this.reader = new AnnotatedBeanDefinitionReader(this);
        // 通过给定的BeanDefinitionRegistry创建
        // 核心方法 doScan()，返回Set<BeanDefinitionHolder>
		this.scanner = new ClassPathBeanDefinitionScanner(this);
	}
```

org/springframework/context/annotation/AnnotatedBeanDefinitionReader.java
```java
	/**
	 * Create a new {@code AnnotatedBeanDefinitionReader} for the given registry.
	 * <p>If the registry is {@link EnvironmentCapable}, e.g. is an {@code ApplicationContext},
	 * the {@link Environment} will be inherited, otherwise a new
	 * {@link StandardEnvironment} will be created and used.
	 * @param registry the {@code BeanFactory} to load bean definitions into,
	 * in the form of a {@code BeanDefinitionRegistry}
	 * @see #AnnotatedBeanDefinitionReader(BeanDefinitionRegistry, Environment)
	 * @see #setEnvironment(Environment)
	 */
	public AnnotatedBeanDefinitionReader(BeanDefinitionRegistry registry) {
		this(registry, getOrCreateEnvironment(registry));
	}
```

### BeanDefinitionRegistry接口定义
org/springframework/beans/factory/support/BeanDefinitionRegistry.java
```java
/**
 * Interface for registries that hold bean definitions, for example RootBeanDefinition
 * and ChildBeanDefinition instances. Typically implemented by BeanFactories that
 * internally work with the AbstractBeanDefinition hierarchy.
 *
 * <p>This is the only interface in Spring's bean factory packages that encapsulates
 * <i>registration</i> of bean definitions. The standard BeanFactory interfaces
 * only cover access to a <i>fully configured factory instance</i>.
 *
 * <p>Spring's bean definition readers expect to work on an implementation of this
 * interface. Known implementors within the Spring core are DefaultListableBeanFactory
 * and GenericApplicationContext.
 *
 */
 
 // - 被BeanFactory实现，持有BeanDefinition
public interface BeanDefinitionRegistry extends AliasRegistry {

	void registerBeanDefinition(String beanName, BeanDefinition beanDefinition)
			throws BeanDefinitionStoreException;
            
	void removeBeanDefinition(String beanName) throws NoSuchBeanDefinitionException;
}
```

AnnotationConfigApplicationContext继承了GenericApplicationContext,GenericApplicationContext实现了BeanDefinitionRegistry

org/springframework/context/support/GenericApplicationContext.java
```java
	private final DefaultListableBeanFactory beanFactory;

	public void registerBeanDefinition(String beanName, BeanDefinition beanDefinition)
			throws BeanDefinitionStoreException {

		this.beanFactory.registerBeanDefinition(beanName, beanDefinition);
	}

```
org/springframework/beans/factory/support/DefaultListableBeanFactory.java  
```java
	@Override
	public void registerBeanDefinition(String beanName, BeanDefinition beanDefinition)
			throws BeanDefinitionStoreException {

		if (beanDefinition instanceof AbstractBeanDefinition) {
			try {
                // 校验有效性，并为Bean准备@override方法定义
				((AbstractBeanDefinition) beanDefinition).validate();
			}
			catch (BeanDefinitionValidationException ex) {
				throw new BeanDefinitionStoreException(beanDefinition.getResourceDescription(), beanName,
						"Validation of bean definition failed", ex);
			}
		}

        //  Map<String, BeanDefinition> beanDefinitionMap
        // 使用beanName作为map的key
		BeanDefinition existingDefinition = this.beanDefinitionMap.get(beanName);
		if (existingDefinition != null) {
            // 放入 beanDefinitionMap
			this.beanDefinitionMap.put(beanName, beanDefinition);
		}
		else {
            // bean工厂创建阶段是否开始
			if (hasBeanCreationStarted()) {
				// Cannot modify startup-time collection elements anymore (for stable iteration)
				synchronized (this.beanDefinitionMap) {
					this.beanDefinitionMap.put(beanName, beanDefinition);
					List<String> updatedDefinitions = new ArrayList<>(this.beanDefinitionNames.size() + 1);
					updatedDefinitions.addAll(this.beanDefinitionNames);
					updatedDefinitions.add(beanName);
					this.beanDefinitionNames = updatedDefinitions;
                    // 更新手动注册的单例beanName名称列表
					removeManualSingletonName(beanName);
				}
			}
			else {
				// Still in startup registration phase
				this.beanDefinitionMap.put(beanName, beanDefinition);
				this.beanDefinitionNames.add(beanName);
                // 更新手动注册的单例的名称列表
				removeManualSingletonName(beanName);
			}
			this.frozenBeanDefinitionNames = null;
		}

		if (existingDefinition != null || containsSingleton(beanName)) {
            // 重置bean definition caches
			resetBeanDefinition(beanName);
		}
	}
```

### getBean方法
org/springframework/beans/factory/support/AbstractBeanFactory.java的doGetBean()

```java

```