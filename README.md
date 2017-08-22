# selenium-statsd-exporter

The script is used to analyse the Selenium grid console and export queue size, available and busy browsers to Statsd. In it's original use it is used along with the [statsd_exporter](https://github.com/prometheus/statsd_exporter) of Prometheus.


## Docker usage



    docker pull prom/statsd-exporter
    docker build -t selenium-watch .
    docker run -d -p 9102:9102 -p 9125:9125 -p 9125:9125/udp \
        -v $PWD/statsd_mapping.conf:/tmp/statsd_mapping.conf \
        --name statsd-exporter \
        prom/statsd-exporter -statsd.mapping-config=/tmp/statsd_mapping.conf

    docker -d --link statsd-exporter \
           -e STATSD_HOST=statsd-exporter \
           -e STATSD_PORT=9125 \
           -e CONSOLE_URI=http://your.selenium.example:4444/grid/console \
           selenium-watch

The related metrics can then be found under:

    http://localhost:9102/metrics

## License

MIT License
