# xhprof extension for PHP7 and PHP8
Contains the code to build and generate Xhprof extension for PHP.

XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based navigational interface. The raw data collection component is implemented in C (as a PHP extension). The reporting/UI layer is all in PHP. It is capable of reporting function-level inclusive and exclusive wall times, memory usage, CPU times and number of calls for each function. Additionally, it supports ability to compare two runs (hierarchical DIFF reports), or aggregate results from multiple runs.

The code was extracted from [https://github.com/longxinH/xhprof](https://github.com/longxinH/xhprof), to keep only the extension in this repository. The Hxprof UI can be found in another repo.

# PHP Versions
- 7.2
- 7.3
- 7.4
- 8.0
- 8.1
- 8.2

# Installation
```
git clone https://github.com/marcelovani/xhprof_extension.git ./xhprof
cd xhprof/extension/
phpize
./configure --with-php-config=/usr/local/bin/php-config
make && sudo make install
```

#### configuration add to your php.ini
```
[xhprof]
extension = xhprof.so
xhprof.output_dir = /tmp/xhprof
```

### php.ini configuration
|      Options        |  Defaults  |  Version  |  Explain  |
| --------------- |:-------------:|:-------------:|:---------|
|xhprof.output_dir  | "" | All |Output directory|
|xhprof.sampling_interval  | 100000 | >= v2.* | Sampling interval to be used by the sampling profiler, in microseconds|
|xhprof.sampling_depth  | INT_MAX | >= v2.* | Depth to trace call-chain by the sampling profiler|
|xhprof.collect_additional_info  | 0 | >= v2.1 | Collect mysql_query, curl_exec internal info. The default is 0. Open value is 1|

## Composer
You can use Composer to include this repo into your project, by adding the following lines on composer.json and then
running `composer require marcelovani/xhprof_extension`

```
    "repositories": [
        {
            "type": "vcs",
            "url": "https://github.com/marcelovani/xhprof_extension.git"
        }
    ]
```

## Docker
This image can be built with Docker and pushed to Docker hub.

Commands:
- `make build`: Will pull latest changes from origin repo, build and test the extension
- `make deploy-image`: Will deploy to Docker hub. Remember to update the namespace in .env file.

## Dockerfile / Docker Compose
You can use this Dockerfile as a starting point to integrate the extension with your project.

```Dockerfile
FROM php:8-fpm-alpine

# Download script to install PHP extensions and dependencies
ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync

# Install necessary packages for building the extension
RUN apk --no-cache add git autoconf g++ make

# Clone the xhprof repository and build the xhprof extension.
RUN git clone https://github.com/marcelovani/xhprof_extension.git /tmp/xhprof
RUN cd /tmp/xhprof/extension/ \
    && phpize \
    && ./configure --with-php-config=/usr/local/bin/php-config \
    && make \
    && make install

# Enable the xhprof extension in php.ini
RUN echo "[xhprof]" > /usr/local/etc/php/conf.d/xhprof.ini \
    && echo "extension = xhprof.so" >> /usr/local/etc/php/conf.d/xhprof.ini \
    && echo "xhprof.output_dir = /tmp/xhprof" >> /usr/local/etc/php/conf.d/xhprof.ini
```

## See further documentation on origin repo
[https://github.com/longxinH/xhprof/README.md](https://github.com/longxinH/xhprof/blob/master/README.md)
