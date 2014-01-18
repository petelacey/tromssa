Tromssa::Application.config.middleware.insert_after RequestStore::Middleware, "Tromssa::Middleware::GetUser"
Tromssa::Application.config.middleware.insert_after RequestStore::Middleware, "Tromssa::Middleware::GetClub"
