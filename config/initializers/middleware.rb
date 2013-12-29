Tromssa::Application.config.middleware.insert_after ActionDispatch::ParamsParser, "Tromssa::Middleware::GetUser"
Tromssa::Application.config.middleware.insert_after ActionDispatch::ParamsParser, "Tromssa::Middleware::GetClub"
