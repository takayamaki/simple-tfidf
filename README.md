# simple-tfidf
This is simply tf-idf calculation script.

## usage
```
ruby tfidf.rb [-l LIMIT] [-b] targetDir
```
Script will find document recursively from targetDir, calclate tf-idf, and print result as JSON.

## options
-l, --limit LIMIT                Limit of words each docs. Default:no limit
-b, --bigdecimal [PRECISION]     Useing BigDecimal for calculation. You can specify precision by PRECISION. Default:10

## licenses
Copyright (c) 2017 takayamaki Released under the MIT license https://opensource.org/licenses/mit-license.php
