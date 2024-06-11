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
/path/to/php7/bin/phpize
./configure --with-php-config=/path/to/php7/bin/php-config
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

## Docker
You can use the Dockerfile in the docker folder as a starting point to build the extension using Docker.

## See further documentation
[https://github.com/longxinH/xhprof/README.md](https://github.com/longxinH/xhprof/blob/master/README.md)
