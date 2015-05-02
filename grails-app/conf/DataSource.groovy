dataSource {
    pooled = true
    /*driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""*/
	driverClassName = "com.mysql.jdbc.Driver"
	dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
	//dialect = "ics.MySQLUTF8InnoDBDialect"
	dbCreate = "update"
	username = "ics"
	password = "ics"
	url = "jdbc:mysql://localhost:3306/ics?autoreconnect=true&zeroDateTimeBehavior=convertToNull&useUnicode=yes&characterEncoding=UTF-8"
    properties {
        maxActive = 50
        maxIdle = 25
        minIdle = 5
        initialSize = 5
        minEvictableIdleTimeMillis = 60000
        timeBetweenEvictionRunsMillis = 60000
        maxWait = 10000
        validationQuery = "/* ping */"
    }
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        
        /* for normal development */
        dataSource {
	username = "ics"
	password = "ics"
	url = "jdbc:mysql://localhost:3306/ics?autoreconnect=true&zeroDateTimeBehavior=convertToNull&useUnicode=yes&characterEncoding=UTF-8"
        }

        /* for development/test with nvcc data
        dataSource {
	username = "nvcc"
	password = "nvcc"
	url = "jdbc:mysql://localhost:3306/nvcc?autoreconnect=true&zeroDateTimeBehavior=convertToNull&useUnicode=yes&characterEncoding=UTF-8"
        } */

        /* for development/test with rvto data
        dataSource {
	username = "rvto"
	password = "rvto"
	url = "jdbc:mysql://localhost:3306/rvto?autoreconnect=true&zeroDateTimeBehavior=convertToNull&useUnicode=yes&characterEncoding=UTF-8"
        } */

        hibernate {
            show_sql = false
    	    cache.use_query_cache = false
        }
    }
    test {
        //for nvcc
        dataSource {
	username = "nvcc"
	password = "nvcc"
	url = "jdbc:mysql://localhost:3306/nvcc?autoreconnect=true&zeroDateTimeBehavior=convertToNull"
        }
    }
    production {
        /* for NVCC */
        dataSource {
	username = "ics"
	password = "kr1shna"
	url = "jdbc:mysql://localhost:3306/ics?autoreconnect=true&zeroDateTimeBehavior=convertToNull&useUnicode=yes&characterEncoding=UTF-8"
        }
        //for RVTO
        /*dataSource {
	username = "rvto"
	password = "rvto"
	url = "jdbc:mysql://localhost:3306/rvto?autoreconnect=true&zeroDateTimeBehavior=convertToNull"
        }*/
    }
}
