
hibernate {
	cache.use_second_level_cache = true
	cache.use_query_cache = true
	cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
	development {
		dataSource {
		
			pooled = false
			dbCreate = "update" // one of 'create', 'create-drop','update'
			url = "jdbc:postgresql://localhost:5432/ucpvmworld"
			driverClassName = "org.postgresql.Driver"
			username = "ucpuser"
			password = "ucpuser"
			loggingSql = false
			
		}
	}
	
	test {
		dataSource {
			pooled = true
			driverClassName = "org.h2.Driver"
			username = "sa"
			password = ""
			dbCreate = "update"
			url = "jdbc:h2:mem:testDb;MVCC=TRUE"
		}
	}
	production {
		dataSource {
			pooled = false
			dbCreate = "update" // one of 'create', 'create-drop','update'
			url = "jdbc:postgresql://localhost:5432/ucpvmworld"
			driverClassName = "org.postgresql.Driver"
			username = "ucpuser"
			password = "ucpuser"
			loggingSql = false
		}
	}
	
	staging {
		dataSource {
			pooled = false
			dbCreate = "update" // one of 'create', 'create-drop','update'
			url = "jdbc:postgresql://localhost:5432/ucpvmworld"
			driverClassName = "org.postgresql.Driver"
			username = "ucpuser"
			password = "ucpuser"
			loggingSql = false
		}
	}
	
}
