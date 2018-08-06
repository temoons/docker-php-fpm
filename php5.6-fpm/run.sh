if [ "${TIMEZONE}" == "" ]; then
   TIMEZONE='Asia/Shanghai'
fi

echo "date.timezone=${TIMEZONE}" >> /usr/local/etc/php/conf.d/default.ini && \
echo ${TIMEZONE} > /etc/timezone && \
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

php-fpm