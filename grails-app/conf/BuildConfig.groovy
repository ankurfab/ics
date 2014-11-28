grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"
grails.project.war.file = "target/${appName}.war"

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve

    repositories {
        inherits true // Whether to inherit repository definitions from plugins
        grailsPlugins()
        grailsHome()
        grailsCentral()
        mavenCentral()

        // uncomment these to enable remote dependency resolution from public Maven repositories
        //mavenCentral()
        //mavenLocal()
        mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
	mavenRepo "http://repo.grails.org/grails/plugins"
    }
    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.

        runtime 'mysql:mysql-connector-java:5.1.16'
    }

    plugins {
        runtime ":hibernate:$grailsVersion"
        runtime ":jquery:1.8.0"
        runtime ":resources:1.1.6"
	

	//runtime ":jquery-validation-ui:1.4"

        build ":tomcat:$grailsVersion"
        
        //compile ":spring-security-core:1.2.4"
        compile ":simple-captcha:0.9.1"
        compile ":browser-detection:0.4.1"
        compile ":csv:0.3.1"
        compile ":bruteforce-defender:1.0"
        compile ":mandrill:0.1"
        compile ":quartz:1.0.1"
        compile ":quartz-monitor:1.0"
        compile ":spring-mobile:0.5.1"
	compile ":grails-melody:1.51.0"

        // Uncomment these for better performance in Live
        /*runtime ":zipped-resources:1.0"
        runtime ":cached-resources:1.0"
        runtime ":yui-minify-resources:0.1.4"
        compile ":cache-headers:1.1.5"*/
    }
}
