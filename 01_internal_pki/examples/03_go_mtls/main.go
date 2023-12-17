package main

import (
	"crypto/tls"
	"crypto/x509"
	"flag"
	"log"
	"net/http"
	"os"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello, World!\n"))
}

func main() {
	caCertPath := flag.String("cacert", "ca.crt", "Path to CA certificate")
	serverCertPath := flag.String("cert", "server.crt", "Path to server certificate")
	serverKeyPath := flag.String("key", "server.key", "Path to server key")
	flag.Parse()

	caCert, err := os.ReadFile(*caCertPath)
	if err != nil {
		log.Fatalf("Reading CA certificate: %v", err)
	}
	caCertPool := x509.NewCertPool()
	caCertPool.AppendCertsFromPEM(caCert)

	tlsConfig := &tls.Config{
		ClientCAs:  caCertPool,
		ClientAuth: tls.RequireAndVerifyClientCert,
	}

	server := &http.Server{
		Addr:      ":9443",
		TLSConfig: tlsConfig,
		Handler:   http.HandlerFunc(helloHandler),
	}

	log.Fatal(server.ListenAndServeTLS(*serverCertPath, *serverKeyPath))
}
