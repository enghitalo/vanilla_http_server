module main

import http_server
import http_server.http1_1.request_parser
import http_server.http1_1.response

fn handle_request(req_buffer []u8, client_conn_fd int) ![]u8 {
	req := request_parser.decode_http_request(req_buffer)!
	method := req.method.to_string(req.buffer)
	path := req.path.to_string(req.buffer)

	match method {
		'GET' {
			match path {
				'/' {
					return home_controller([])
				}
				'/users' {
					return get_users_controller([])
				}
				else {
					if path.starts_with('/user/') {
						id := path[6..]
						return get_user_controller([id])
					}
					return response.tiny_bad_request_response
				}
			}
		}
		'POST' {
			if path == '/user' {
				return create_user_controller([])
			}
			return response.tiny_bad_request_response
		}
		else {
			return response.tiny_bad_request_response
		}
	}

	return response.tiny_bad_request_response
}

fn main() {
	mut server := http_server.new_server(http_server.ServerConfig{
		port:            3000
		io_multiplexing: unsafe { http_server.IOBackend(0) }
		request_handler: handle_request
	})!
	server.run()
}
