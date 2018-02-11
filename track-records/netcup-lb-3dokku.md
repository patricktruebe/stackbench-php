# Netcup

## Stack specification

[Netcup VPS 500 G8](https://www.netcup.de/vserver/vps.php)

1x Nginx 1.13.1 HTTP load balancer w/ Let's Encrypt

3x Dokku v0.11.3 w/ Let's Encrypt _tweaked for heavy duty operations_

cpu.php performance of
```
Took 56000 loops for 2.000000 seconds load
Allocated peak mem was 24 MiB
```

## Performance guarantees

|           Type             | CPU max  | Output max | Rps @ LB |       Limiting factor        |
|----------------------------|----------|------------|----------|------------------------------|
| Static Files               | 1ms      | 1kb        | ~10k     | Proxy latency                |
| Tiny php scripts           | 10ms     | 10kb       | >1k      | Proxy latency / GbE uplink   |
| Wordpress-like php scripts | 2s       | 200kb      | #nproc/t | CPU performance              |
| IO/Wait-idle php scripts   | 5s       | 1MB        | #nproc/t | somaxconn queue limit        |

## Static File
Single Node:
```bash
Running 30s test @ https://s01.app.relenda.net/stylesheets/main.css
  4 threads and 128 connections
  Thread calibration: mean lat.: 2753.813ms, rate sampling interval: 10215ms
  Thread calibration: mean lat.: 2766.512ms, rate sampling interval: 10321ms
  Thread calibration: mean lat.: 3096.938ms, rate sampling interval: 9838ms
  Thread calibration: mean lat.: 2780.930ms, rate sampling interval: 10346ms
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     9.94s     2.76s   19.17s    70.28%
    Req/Sec     1.04k   223.17     1.16k    80.00%
  111235 requests in 30.03s, 88.57MB read
Requests/sec:   3704.50
Transfer/sec:      2.95MB
```

Loadbalancer with 3 Nodes:
```bash
Running 30s test @ https://s01.lb.relenda.net/stylesheets/main.css
  4 threads and 128 connections
  Thread calibration: mean lat.: 16.921ms, rate sampling interval: 100ms
  Thread calibration: mean lat.: 16.707ms, rate sampling interval: 100ms
  Thread calibration: mean lat.: 15.083ms, rate sampling interval: 91ms
  Thread calibration: mean lat.: 16.266ms, rate sampling interval: 95ms
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    39.50ms   68.80ms 668.67ms   87.19%
    Req/Sec     2.52k   465.16     5.51k    77.71%
  299185 requests in 30.00s, 238.23MB read
Requests/sec:   9972.85
Transfer/sec:      7.94MB
```

## Tiny php script
Single Node:
```bash
Running 30s test @ https://s01.app.relenda.net/info.php
  4 threads and 128 connections
  Thread calibration: mean lat.: 4583.771ms, rate sampling interval: 16769ms
  Thread calibration: mean lat.: 4579.485ms, rate sampling interval: 16670ms
  Thread calibration: mean lat.: 4598.487ms, rate sampling interval: 16744ms
  Thread calibration: mean lat.: 4364.286ms, rate sampling interval: 15482ms
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    18.29s     5.34s   27.62s    57.69%
    Req/Sec   189.00      0.00   189.00    100.00%
  22948 requests in 30.01s, 1.97GB read
Requests/sec:    764.67
Transfer/sec:     67.23MB
```

Loadbalancer with 3 Nodes:
```bash
Running 30s test @ https://s01.lb.relenda.net/info.php
  4 threads and 128 connections
  Thread calibration: mean lat.: 4238.723ms, rate sampling interval: 15745ms
  Thread calibration: mean lat.: 4142.978ms, rate sampling interval: 14557ms
  Thread calibration: mean lat.: 4179.628ms, rate sampling interval: 15687ms
  Thread calibration: mean lat.: 4239.766ms, rate sampling interval: 15785ms
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    17.23s     5.04s   26.94s    58.15%
    Req/Sec   298.25      3.11   303.00     75.00%
  35787 requests in 30.01s, 3.07GB read
Requests/sec:   1192.59
Transfer/sec:    104.84MB
```

## Wordpress-like php scripts
Single Node:
```bash
Running 30s test @ https://s01.app.relenda.net/cpu.php
  4 threads and 32 connections
  Thread calibration: mean lat.: 5686.784ms, rate sampling interval: 16089ms
  Thread calibration: mean lat.: 5694.720ms, rate sampling interval: 16089ms
  Thread calibration: mean lat.: 5349.632ms, rate sampling interval: 16023ms
  Thread calibration: mean lat.: 9223372036854776.000ms, rate sampling interval: 10ms
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    19.33s     5.70s   28.08s    52.63%
    Req/Sec     0.42      7.34   200.00     99.65%
  56 requests in 30.06s, 13.51KB read
Requests/sec:      1.86
Transfer/sec:     460.09B
```

Loadbalancer with 3 Nodes:
```bash
Running 30s test @ https://s01.lb.relenda.net/cpu.php
  4 threads and 32 connections
  Thread calibration: mean lat.: 4958.247ms, rate sampling interval: 16105ms
  Thread calibration: mean lat.: 4896.036ms, rate sampling interval: 16097ms
  Thread calibration: mean lat.: 5233.561ms, rate sampling interval: 16056ms
  Thread calibration: mean lat.: 5531.861ms, rate sampling interval: 16105ms
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    19.14s     5.72s   28.11s    60.50%
    Req/Sec     1.00      0.00     1.00    100.00%
  168 requests in 30.06s, 46.81KB read
Requests/sec:      5.59
Transfer/sec:      1.56KB
```

## IO/Wait-idle php scripts
Single Node:
```bash
Running 30s test @ https://s01.app.relenda.net/io.php
  4 threads and 128 connections
  Thread calibration: mean lat.: 4908.902ms, rate sampling interval: 18006ms
  Thread calibration: mean lat.: 5308.185ms, rate sampling interval: 15998ms
  Thread calibration: mean lat.: 5706.163ms, rate sampling interval: 17989ms
  Thread calibration: mean lat.: 6107.801ms, rate sampling interval: 17989ms
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    19.94s     5.45s   28.90s    57.89%
    Req/Sec     0.75      0.43     1.00    100.00%
  120 requests in 30.04s, 19.69KB read
Requests/sec:      3.99
Transfer/sec:     671.00B
```

Loadbalancer with 3 Nodes:
```bash
Running 30s test @ https://s02.lb.relenda.net/io.php
  4 threads and 128 connections
  Thread calibration: mean lat.: 4943.772ms, rate sampling interval: 15745ms
  Thread calibration: mean lat.: 9015.978ms, rate sampling interval: 18055ms
  Thread calibration: mean lat.: 4943.559ms, rate sampling interval: 15745ms
  Thread calibration: mean lat.: 4942.634ms, rate sampling interval: 15745ms
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    19.71s     5.57s   28.87s    57.89%
    Req/Sec     2.00      0.00     2.00    100.00%
  351 requests in 30.18s, 73.15KB read
Requests/sec:     11.63
Transfer/sec:      2.42KB
```
