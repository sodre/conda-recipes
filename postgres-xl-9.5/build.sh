#!/bin/sh

export LIBS='-ltinfo'

if uname | grep Darwin > /dev/null; then
    # 10.9 appears to have an issue with libxml2; clang/ld isn't respecting
    # the flags above, and it attempts to link with /usr/lib/libxml2.2.dynlib,
    # which results in an error and ./configure time.  @Aaron, have you seen
    # this before?  Can you reproduce the error?
    ./configure --prefix=$PREFIX \
        --with-includes=$PREFIX/include \
        --with-libraries=$PREFIX/lib \
        --with-readline        \
        --with-python          \
        --with-openssl         
#        --with-libxml          \
#        --with-libxslt
else
    ./configure --prefix=$PREFIX \
        --with-includes=$PREFIX/include \
        --with-libraries=$PREFIX/lib \
        --enable-thread-safety \
        --with-readline        \
        --with-python          \
        --with-openssl         
#        --with-libxml          \
#        --with-libxslt
fi

make 
make install

pushd contrib
make 
make install
popd
