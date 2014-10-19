## Introduction

pgantenna is an open source monitoring framework for Postgresql clusters.
<br/><br/>
The <a href="http://no0p.github.io/pgantenna/">project page</a> provides an overview of the framework.
<br/><br/>
The <a href="https://github.com/no0p/pgantenna/wiki">project wiki</a> has documentation on running and customizing pgantenna.

## Installation

The best way to run pgantenna is to launch a docker container based on a publicly available image:

```
docker run -p 24831:24831 -p 80:80 pgantenna
```

You can now direct your postgresql cluster to begin shipping statistics to pgantenna by installing and <a href="https://github.com/no0p/pgsampler/wiki/Configuration">configuring pgsampler</a> to the pgantenna host.
