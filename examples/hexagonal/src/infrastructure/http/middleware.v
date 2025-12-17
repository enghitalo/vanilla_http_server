module http

import domain

pub struct SimpleAuthService {
	repo domain.UserRepository
}

pub fn new_simple_auth_service(repo domain.UserRepository) SimpleAuthService {
	return SimpleAuthService{
		repo: repo
	}
}

pub fn (a SimpleAuthService) authenticate(credentials domain.AuthCredentials) !domain.User {
	user := a.repo.find_by_username(credentials.username) or {
		return error('Authentication failed')
	}
	// In production, use a secure password hash check
	if user.password == credentials.password {
		return user
	}
	return error('Authentication failed')
}
