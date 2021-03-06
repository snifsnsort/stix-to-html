# STIX to HTML + Java

A Java application for running stix-to-html transformations against
STIX input documents. More information about STIX can be found at
http://stix.mitre.org.

## Overview

The primary goal of the Java stix-to-html application is to make it easy
for STIX users to render HTML views of STIX content. The stix-to-html
application can render single STIX documents at a time. Users wanting to
render multiple documents or take advantage of stix-to-html 
[customization](https://github.com/STIXProject/stix-to-html#customization)
can leverage any XSLT 2.0 engine (e.g. [Saxon](http://saxon.sourceforge.net/))
to do so. Please see the stix-to-html 
[usage notes](https://github.com/STIXProject/stix-to-html#usage-notes) for
more information about advanced uses.


## Dependencies

The Java stix-to-html application depends on a working, installed JRE 
(Java Runtime Environment). This application has been developed and tested
on Java 7.


## Versioning

Releases of the Java stix-to-html application will comply with the 
Semantic Versioning specification at http://semver.org/.  

## Building

This project uses Maven 3.2+ as the primary build tool. See 
http://maven.apache.org for details.

Common Maven goals (complete list [here](http://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html#Lifecycle_Reference)):

    clean             - Deletes the target/ directory and associated build files.
    package           - Builds the project, creates the jar, runs the tests
    
To run maven behind a proxy, you'll need to add a `<proxies>` section to your Maven
`$HOME/.m2/settings.xml` file. More details on how to configure Maven to use a proxy
can be found here: http://maven.apache.org/guides/mini/guide-proxies.html.

## Releases

Relases of stix-to-html will include a binary package containing the following files:

```
stix-to-html/
    stix-to-html.jar      # Java stix-to-html binary
    stix-to-html.bat      # Windows script for launching stix-to-html.jar
    stix-to-html.sh       # Bash script for launching stix-to-html.jar
    LICENSE.txt           # License information
    README.md             # This README file.
```

### Usage

The following commands can be used to run the Java stix-to-html application.

**Windows**
```
> stix-to-html -i INPUT.xml -o OUTPUT.html
> stix-to-html --indir C:\path\to\stix\files\ --outdir C:\path\to\output\
```

**Linux/OSX**
```
$ ./stix-to-html.sh -i INPUT.xml -o OUTPUT.html
$ ./stix-to-html.sh --indir /path/to/stix/files --outdir /path/to/output/
```

**Java**
```
$ java -jar stix-to-html.jar -i INPUT.xml -o OUTPUT.html
$ java -jar stix-to-html.jar --indir /path/to/stix/files --outdir /path/to/output/
```


## Feedback

You are encouraged to provide feedback by commenting on open issues or 
signing up for the [STIX discussion list](http://stix.mitre.org/community/registration.html)
and posting your questions.
