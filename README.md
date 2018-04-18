# docker-tomcat

QuintoAndar Tomcat-based docker image.

* Sets UnlockExperimentalVMOptions, UseCGroupMemoryLimitForHeap, MaxRAMFraction for automatically configuring JVM memory allocation (see [this](https://blogs.oracle.com/java-platform-group/java-se-support-for-docker-cpu-and-memory-limits))
* Automatically injects environment variables into the application context
* Translates CMD into application parameters
