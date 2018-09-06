##
FROM alpine:3.5
ENV BASE_PACKAGES="\
  dumb-init \
  musl \
  linux-headers \
  build-base \
  bash \
  git"
