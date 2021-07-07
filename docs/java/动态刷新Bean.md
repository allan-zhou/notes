- 什么是Bean
- 怎么使用Bean
- 什么是Bean Scope
- Bean的生命周期

A bean is an object that is instantiated, assembled, and otherwise managed by a Spring IoC container.
This object delegates the job of constructing and instantiating such dependencies to an IoC container, the Spring lightweight container.

```java
public class Person {
    private Animal animal;
 
    public Person(Animal animal) {
        this.animal = animal;
    }
 
    // getter, setter
}
```

```java
Animal animal = new Animal("fuffy", 5);
Person person = new Person(animal);
```

### 常用注释
- @Component : class-level annotation which by default denotes a bean with the same name as the class name with a lowercase first letter. It can be specified a different name using the value argument of the annotation
- @Repository : class-level annotation representing the DAO layer of an application; it enables an automatic persistence exception translation.
- @Service : class-level annotation representing where the business logic usually resides and can flavor the reuse of the code.
- @Controller : class-level annotation representing the controllers in Spring MVC (Model-View-Controller). See also @RestController for the REST “mode”.
- @Configuration : class-level annotation to say that it can contain bean definition methods annotated with @Bean

### A Spring Bean has a lifecycle composed of the following steps :
- Bean Definition : the bean is defined using annotations or XML
- Bean Instantiation : Spring instantiate bean objects just like we would manually create a Java object instance and load the object into the ApplicationContext
- Populating Bean properties : Spring scans the beans that implement Aware interfaces and starts setting relevant properties as id, scope and the default values based on the bean definition
- Pre-Initialization : Spring’s BeanPostProcessors get into action in this phase. The postProcessBeforeInitialization() methods do their job. Also, @PostConstruct annotated methods run right after them
- AfterPropertiesSet : Spring executes the afterPropertiesSet() methods of the beans which implement InitializingBean
- Custom Initialization : Spring triggers the initialization methods that we defined in the initMethod attribute of our @Bean annotations
- Post-initialization : Spring’s BeanPostProcessors are in action for the second time. This phase triggers the postProcessAfterInitialization() methods
- Ready : now the bean is created and injected into all the dependencies
- Pre-Destroy : Spring triggers @PreDestroy annotated methods in this phase
- Destroy : Spring executes the destroy() methods of DisposableBean implementations
- Custom Destruction : We can define custom destruction hooks with the destroyMethod attribute in the @Bean annotation and Spring runs them in the last phase


ApplicationContext->
DefaultListableBeanFactory -> ConfigurableListableBeanFactory -> ListableBeanFactory -> BeanFactory

AbstractBeanFactory

### BeanFactory vs ApplicationContext

BeanFactory loads beans on-demand, while ApplicationContext loads all beans at startup
ApplicationContext is considered a heavy IOC container because its eager-loading strategy loads all the beans at startup. BeanFactory is lightweight by comparison and could be handy in memory-constrained systems. 

### Bean Scope

### ClassPathXmlApplicationContext

org/springframework/context/support/ClassPathXmlApplicationContext.java, 行137：
```java
    public ClassPathXmlApplicationContext(
            String[] configLocations, boolean refresh, @Nullable ApplicationContext parent)
            throws BeansException {

        super(parent);
        setConfigLocations(configLocations);
        if (refresh) {
            refresh();
        }
    }
```
org/springframework/context/support/AbstractApplicationContext.java，行457
```java
    /**
    * Return the ResourcePatternResolver to use for resolving location patterns
    * into Resource instances. Default is a
    * {@link org.springframework.core.io.support.PathMatchingResourcePatternResolver},
    * supporting Ant-style location patterns.
    * <p>Can be overridden in subclasses, for extended resolution strategies,
    * for example in a web environment.
    * <p><b>Do not call this when needing to resolve a location pattern.</b>
    * Call the context's {@code getResources} method instead, which
    * will delegate to the ResourcePatternResolver.
    * @return the ResourcePatternResolver for this context
    * @see #getResources
    * @see org.springframework.core.io.support.PathMatchingResourcePatternResolver
    */
    protected ResourcePatternResolver getResourcePatternResolver() {
        return new PathMatchingResourcePatternResolver(this);
    }
```

org/springframework/context/support/AbstractRefreshableConfigApplicationContext.java，行76
```java
	/**
	 * Set the config locations for this application context.
	 * <p>If not set, the implementation may use a default as appropriate.
	 */
	public void setConfigLocations(@Nullable String... locations) {
		if (locations != null) {
			Assert.noNullElements(locations, "Config locations must not be null");
			this.configLocations = new String[locations.length];
			for (int i = 0; i < locations.length; i++) {
				this.configLocations[i] = resolvePath(locations[i]).trim();
			}
		}
		else {
			this.configLocations = null;
		}
	}
```
```java
	/**
	 * Resolve the given path, replacing placeholders with corresponding
	 * environment property values if necessary. Applied to config locations.
	 * @param path the original file path
	 * @return the resolved file path
	 * @see org.springframework.core.env.Environment#resolveRequiredPlaceholders(String)
	 */
	protected String resolvePath(String path) {
		return getEnvironment().resolveRequiredPlaceholders(path);
	}

```

org/springframework/core/env/AbstractPropertyResolver.java，行206
```java
	@Override
	public String resolveRequiredPlaceholders(String text) throws IllegalArgumentException {
		if (this.strictHelper == null) {
			this.strictHelper = createPlaceholderHelper(false);
		}
		return doResolvePlaceholders(text, this.strictHelper);
	}
```

### ClassPathXmlApplicationContext - Refresh()

org/springframework/context/support/AbstractApplicationContext.java，行516
```java
	@Override
	public void refresh() throws BeansException, IllegalStateException {
		synchronized (this.startupShutdownMonitor) {
			// Prepare this context for refreshing.
			prepareRefresh();

			// Tell the subclass to refresh the internal bean factory.
			ConfigurableListableBeanFactory beanFactory = obtainFreshBeanFactory();

			// Prepare the bean factory for use in this context.
			prepareBeanFactory(beanFactory);

			try {
				// Allows post-processing of the bean factory in context subclasses.
				postProcessBeanFactory(beanFactory);

				// Invoke factory processors registered as beans in the context.
				invokeBeanFactoryPostProcessors(beanFactory);

				// Register bean processors that intercept bean creation.
				registerBeanPostProcessors(beanFactory);

				// Initialize message source for this context.
				initMessageSource();

				// Initialize event multicaster for this context.
				initApplicationEventMulticaster();

				// Initialize other special beans in specific context subclasses.
				onRefresh();

				// Check for listener beans and register them.
				registerListeners();

				// Instantiate all remaining (non-lazy-init) singletons.
				finishBeanFactoryInitialization(beanFactory);

				// Last step: publish corresponding event.
				finishRefresh();
			}

			catch (BeansException ex) {
				if (logger.isWarnEnabled()) {
					logger.warn("Exception encountered during context initialization - " +
							"cancelling refresh attempt: " + ex);
				}

				// Destroy already created singletons to avoid dangling resources.
				destroyBeans();

				// Reset 'active' flag.
				cancelRefresh(ex);

				// Propagate exception to caller.
				throw ex;
			}

			finally {
				// Reset common introspection caches in Spring's core, since we
				// might not ever need metadata for singleton beans anymore...
				resetCommonCaches();
			}
		}
	}
```

```java
	/**
	 * Prepare this context for refreshing, setting its startup date and
	 * active flag as well as performing any initialization of property sources.
	 */
	protected void prepareRefresh() {
		// Switch to active.
		this.startupDate = System.currentTimeMillis();
		this.closed.set(false);
		this.active.set(true);
		// Initialize any placeholder property sources in the context environment.
		// 空实现
        initPropertySources();

		// Validate that all properties marked as required are resolvable:
		// see ConfigurablePropertyResolver#setRequiredProperties
		getEnvironment().validateRequiredProperties();

		// Store pre-refresh ApplicationListeners...
		if (this.earlyApplicationListeners == null) {
			this.earlyApplicationListeners = new LinkedHashSet<>(this.applicationListeners);
		}
		else {
			// Reset local application listeners to pre-refresh state.
			this.applicationListeners.clear();
			this.applicationListeners.addAll(this.earlyApplicationListeners);
		}

		// Allow for the collection of early ApplicationEvents,
		// to be published once the multicaster is available...
		this.earlyApplicationEvents = new LinkedHashSet<>();
	}
```

### 属性校验
org/springframework/core/env/AbstractPropertyResolver.java，行144
```java
	public void validateRequiredProperties() {
		MissingRequiredPropertiesException ex = new MissingRequiredPropertiesException();
		for (String key : this.requiredProperties) {
			if (this.getProperty(key) == null) {
				ex.addMissingRequiredProperty(key);
			}
		}
		if (!ex.getMissingRequiredProperties().isEmpty()) {
			throw ex;
		}
	}
```


### Bean生命周期
- @Bean(initMethod = "initMethod", destroyMethod = "destroyMethod")

 BeanNameAware、BeanFactoryAware、InitializingBean、DiposableBean、ApplicationContextAware
容器级别接口
InstantiationAwareBeanPostProcessor、BeanPostProcessor


#### Ant-Style path match
org/springframework/util/AntPathMatcher.java
https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/util/AntPathMatcher.html
