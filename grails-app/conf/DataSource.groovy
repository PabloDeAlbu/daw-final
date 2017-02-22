dataSource {
    pooled = true
    jmxExport = true
    driverClassName = "org.postgresql.Driver"
	dialect = "org.hibernate.spatial.dialect.postgis.PostgisDialect"
	username = "daw_user"
    password = "1234"
}

hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
//    jdbc.use_get_generated_keys = true
//    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
    flush.mode = 'manual' // OSIV session flush mode outside of transactional context
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:postgresql://" + System.env.PG_PORT_5432_TCP_ADDR + "/recorridos"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://" + System.env.PG_PORT_5432_TCP_ADDR + "/recorridos"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:postgresql://" + System.env.PG_PORT_5432_TCP_ADDR + "/recorridos"
        }
    }
}
