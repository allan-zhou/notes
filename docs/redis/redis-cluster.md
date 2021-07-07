# redis cluster

- 客户端分片，如redis的Java客户端jedis也是支持的，使用一致性hash
- 基于代理分片，如codis、twemproxy
- redis-cluster



## ref
- redis集群方案 https://juejin.im/entry/5a54a9cbf265da3e38495e7b
- 一致性hash算法 https://yikun.github.io/2016/06/09/%E4%B8%80%E8%87%B4%E6%80%A7%E5%93%88%E5%B8%8C%E7%AE%97%E6%B3%95%E7%9A%84%E7%90%86%E8%A7%A3%E4%B8%8E%E5%AE%9E%E8%B7%B5/
- reids集群方案怎么做？ https://www.zhihu.com/question/21419897
- redis集群failover机制 https://juejin.im/entry/5b9a1773f265da0aef4dfa56