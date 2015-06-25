# docker-erlang

Dockerized erlang environments

## What is it?

Docker container images that include
[Erlang/OTP](http://www.erlang.org/), along with the
[rebar](https://github.com/rebar/rebar) and
[relx](https://github.com/erlware/relx) build and release tools.

The latest versions of Erlang/OTP R15, R16 and 17 are provided as
tags.

## What can I use it for?

Use it to try out the erlang shell, as an erlang development
environment, or use it as a base image for your own erlang
applications.

## Usage

*   Start a throwaway instance of the erlang shell

        docker run -it --rm correl/erlang:17

*   Run a container to use a development environment

        docker run -it --name erlang-dev correl/erlang:17 /bin/bash
