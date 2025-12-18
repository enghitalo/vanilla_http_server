# Hexagonal Architecture in This Project

This project follows the Hexagonal Architecture (also known as Ports and Adapters) to ensure a clean separation between business logic and external systems such as databases and web frameworks.

## Key Concepts

- **Domain Layer**: Contains core business entities and repository interfaces. It is independent of any external technology.
- **Application Layer**: Implements use cases and orchestrates business logic using domain interfaces.
- **Infrastructure Layer**: Provides concrete implementations for external systems (e.g., databases, HTTP servers) and implements the interfaces defined in the domain layer.
- **Main (Composition Root)**: Wires together the application by injecting infrastructure implementations into the application and domain layers.

## Directory Structure

```
examples/hexagonal/
  src/
    domain/           # Business entities and repository interfaces
    application/      # Use cases
    infrastructure/   # Adapters for DB, HTTP, etc.
      database/       # DB connection and pooling
      http/           # HTTP server and middleware
      repositories/   # DB repository implementations
  main.v              # Composition root
```

## How It Works

- The **domain** layer defines interfaces like `UserRepository` and `ProductRepository`.
- The **infrastructure** layer implements these interfaces for specific technologies (e.g., PostgreSQL, SQLite).
- The **application** layer uses only the interfaces, not the concrete implementations.
- The **main** function wires everything together, choosing which infrastructure implementation to use and injecting it into the application.

## Benefits

- **Testability**: Business logic can be tested independently of external systems.
- **Flexibility**: Easily swap out infrastructure (e.g., change database) without modifying business logic.
- **Maintainability**: Clear separation of concerns and dependency direction.

## Example

- `domain/user.v` defines the `UserRepository` interface.
- `infrastructure/repositories/pg_user_repository.v` implements `UserRepository` for PostgreSQL.
- `main.v` selects and injects the desired repository implementation.

---

For more details, see the code and comments in each layer.
