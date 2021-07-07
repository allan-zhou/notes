# TransmittableThreadLocal 

## InheritableThreadLocal

- InheritableThreadLocal不支持线程池的根本原因是：InheritableThreadLocal是在父线程创建子线程时复制的

JDK的InheritableThreadLocal类可以完成父线程到子线程的值传递。但对于使用线程池等会池化复用线程的执行组件的情况，线程由线程池创建好，并且线程是池化起来反复使用的；这时父子线程关系的ThreadLocal值传递已经没有意义，应用需要的实际上是把 ***任务提交给线程池时*** 的ThreadLocal值传递到 任务执行时。


## TTL实现原理

需要 ***在父线程向线程池提交任务时复制父线程的上下环境*** ，那在子线程中就能够如愿访问到父线程中的本地变量，实现本地环境变量在线程池调用中的透传，这也是TransmittableThreadLocal最本质的实现原理

### TtlRunnable

com.alibaba.ttl.TtlRunnable#run

```java
    /**
     * wrap method {@link Runnable#run()}.
     */
    @Override
    public void run() {
        final Object captured = capturedRef.get(); // 获取线程的ThreadLocalMap
        if (captured == null || releaseTtlValueReferenceAfterRun && !capturedRef.compareAndSet(captured, null)) {
            throw new IllegalStateException("TTL value reference is released after run!");
        }

        final Object backup = replay(captured); // 暂存当前子线程的ThreadLocalMap到backup
        try {
            runnable.run();
        } finally {
            restore(backup); // 恢复线程执行时被改版的Threadlocal对应的值
        }
    }
```

### 使用方式

1. 修饰Runnable和Callable

```java
Runnable task = new RunnableTask();
// 额外的处理，生成修饰了的对象ttlRunnable
Runnable ttlRunnable = TtlRunnable.get(task);
executorService.submit(ttlRunnable);
```

2. 修饰线程池

```java
ExecutorService executorService = ...
// 额外的处理，生成修饰了的对象executorService
executorService = TtlExecutors.getTtlExecutorService(executorService);
```

3. 使用Java Agent来修饰JDK线程池实现类

## reference

- https://github.com/alibaba/transmittable-thread-local
- TTL使用场景 与 设计实现解析的文章 https://github.com/alibaba/transmittable-thread-local/issues/123