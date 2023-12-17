# go mtls

Запустите бинарник `main` на `server-1.bakunin.local`. Запустить можно вот так:

```bash
sudo ./main -cert /etc/step/certs/server-1.bakunin.local.crt -key /etc/step/certs/server-1.bakunin.local.key -cacert /root/.step/certs/root_ca.crt
```

Попробуем обратиться голым curl:

```bash
ne_bknn@client-0:~$ curl https://server-1.bakunin.local:9443
curl: (56) OpenSSL SSL_read: OpenSSL/3.0.11: error:0A00045C:SSL routines::tlsv13 alert certificate required, errno 0
```

Кажется что работает. Укажем сертификаты клиента:

```bash
ne_bknn@client-0:~$ sudo curl --cert /etc/step/certs/client-1.bakunin.local.crt --key /etc/step/certs/client-1.bakunin.local.key --cacert /root/
.step/certs/root_ca.crt https://server-1.bakunin.local:9443
Hello, World!
```

Работает.
