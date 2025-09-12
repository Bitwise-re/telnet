#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <pthread.h>

#define PORT 23 
#define INPUT_BUFFER_SIZE 1024

struct clientThreadData {
	int socket;
	struct sockaddr_in addr;
};

void* clientThreadExecute(void *args) {
	char input[INPUT_BUFFER_SIZE];
	int input_status;
	struct clientThreadData client = *(struct clientThreadData*)args;
	while ((input_status = read(client.socket, input, INPUT_BUFFER_SIZE)) > 0) {
		// process user input
	}
	close(client.socket);
	printf("Client (%s) disconnected\n", inet_ntoa(client.addr.sin_addr));
	return NULL;
}

int main() {
	int server_socket, client_socket;
	struct sockaddr_in server_addr, client_addr;
	socklen_t client_addr_len = sizeof(client_addr);
	// Create the server socket
	server_socket = socket(AF_INET, SOCK_STREAM, 0);
	if (server_socket < 0) {
		perror("Socket creation failed");
		exit(EXIT_FAILURE);
	}
	// Configure the server address
	server_addr.sin_family = AF_INET;
	server_addr.sin_addr.s_addr = INADDR_ANY;
	server_addr.sin_port = htons(PORT);
	// Bind the socket to the specified port
	if (bind(server_socket, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
		perror("Bind failed");
		close(server_socket);
		exit(EXIT_FAILURE);
	}
	// Listen for incoming connections
	if (listen(server_socket, 5) < 0) {
		perror("Listen failed");
		close(server_socket);
		exit(EXIT_FAILURE);
	}
	printf("Server is listening on port %d...\n", PORT);
	// Accept and handle incoming connections
	while ((client_socket = accept(server_socket, (struct sockaddr *)&client_addr, &client_addr_len)) >= 0) {
		printf("Connected to client : %s\n", inet_ntoa(client_addr.sin_addr));
		// Handle the client in a separate thread
		pthread_t clientThread;
		struct clientThreadData threadData;
		threadData.socket = client_socket;
		threadData.addr = client_addr;
		pthread_create(&clientThread, NULL, clientThreadExecute, (void*)&threadData);	
	}
	// Clean up and close the server socket
	close(server_socket);
	return 0;
}
