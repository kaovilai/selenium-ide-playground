Does not work as of https://github.com/SeleniumHQ/selenium-ide/releases/download/4.0.0-alpha.37/Selenium.IDE-4.0.0-alpha.37-arm64.dmg
Issue filed at https://github.com/SeleniumHQ/selenium-ide/issues/1610 [![Selenium IDE issue 1610](https://github.com/kaovilai/selenium-ide-playground/actions/workflows/selenium-ide-1610.yml/badge.svg)](https://github.com/kaovilai/selenium-ide-playground/actions/workflows/selenium-ide-1610.yml)

log
```
3:52:53 PM [debug] [ 'Playing state changed prep for test select opel' ]
3:52:53 PM [info] [ 'Building driver for chrome' ]
3:52:53 PM [info] [ 'Driver has been built for chrome' ]
3:52:53 PM [debug] [ 'Playing state changed playing for test select opel' ]
3:52:53 PM [debug] [ 'executing open|/selenium-ide-playground/bug/select/index.html' ]
3:52:55 PM [debug] [ 'passed open|/selenium-ide-playground/bug/select/index.html' ]
3:52:55 PM [debug] [ 'executing storeWindowHandle|root' ]
3:52:55 PM [debug] [ 'passed storeWindowHandle|root' ]
3:52:55 PM [debug] [ 'executing click|id=cars' ]
3:52:57 PM [debug] [ 'errored click|id=cars' ]
3:52:57 PM [debug] [ 'Playing state changed errored for test select opel' ]
```

These were recorded on from the same selenium-ide install.


Experiments with docker notes
```
docker run -d -p 4444:4444 -p 7900:7900 --shm-size="2g" --net selenium --name selenium seleniarm/standalone-chromium:latest
```
```
docker run --net selenium -v $(pwd)/bug/select/html\ select.side:/tests/test.side ghcr.io/kaovilai/selenium-ide-playground/selenium-side-runner selenium-side-runner --server http://$(docker network  inspect -f '{{range .Containers}}{{.IPv4Address}}{{end}}'  selenium | awk -F/ '{print $1}'):4444/wd/hub -c "goog:chromeOptions.args=[--headless,--nogpu] browserName=chrome" tests/test.side
```