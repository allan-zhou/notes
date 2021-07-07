create database shopDb default charset= utf8;

create TABLE t_store (
    'id' BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
    'store_name' VARCHAR(50) NOT NULL COMMENT '门店名称',
    'promo_count' INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '促销数量',
    'address_detail' VARCHAR(100) NOT NULL DEFAULT '' COMMENT '详细地址',
    'lat' DECIMAL(15,12) NOT NULL DEFAULT 0 COMMENT '维度',
    'lng' DECIMAL(15,12) NOT NULL DEFAULT 0 COMMENT '经度',
    'is_deleted' TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除',
    'create_time' DATETIME NOT NULL COMMENT '创建时间',
    'update_time' DATETIME NOT NULL COMMENT '更新时间'
) ENGINE = INNODB CHARSET = utf8 COMMENT = '门店表';