# Base image
# FROM node:10 as base
# # Create app directory
# WORKDIR /app
# # Install dependencies
# RUN npm install -g selenium-side-runner && which selenium-side-runner && echo "selenium-side-runner installed"

FROM node:14 as test
RUN npm install -g chromedriver selenium-side-runner --unsafe-perm=true --allow-root
# Copy selenium-side-runner
# COPY --from=base /usr/local/bin/selenium-side-runner /usr/local/bin/selenium-side-runner

# Run the tests
# Start a new docker network `docker network create selenium`
# Run a selenium container via $ docker run -d -p 4444:4444 -p 7900:7900 --shm-size="2g" --net selenium --name selenium selenium/standalone-chrome:4.8.3-20230404
# if on arm use $ docker run -d -p 4444:4444 -p 7900:7900 --shm-size="2g" --net selenium --name selenium seleniarm/standalone-chromium:latest
# docker run -d -it -p 4444:4444  -p 7900:7900 --ip 172.19.19.19 --net selenium seleniarm/standalone-chromium:latest
# run this container via $ docker run -it --rm --net selenium -v $(pwd)/bug/select/html\ select.side:/tests/test.side ghcr.io/${{ github.repository_owner }}/${{ github.event.repository.name }}/selenium-side-runner:latest selenium-side-runner --server http://${{ env.SELENIUM_IP }}:4444/wd/hub -c "goog:chromeOptions.args=[--headless,--nogpu] browserName=chrome" tests/test.side
# selenium-side-runner --server http://selenium:4444/wd/hub -c "goog:chromeOptions.args=[--headless,--nogpu] browserName=chrome" tests/test.side
CMD ["selenium-side-runner", "--server", "http://172.17.0.2:4444/wd/hub", "-c", "goog:chromeOptions.args=[--headless,--nogpu] browserName=chrome", "/tests/test.side"]
