
class ApplicationError < StandardError; end

# Errores de validación
class ValidationError < ApplicationError; end
class RequiredFieldError < ValidationError; end
class UniqueFieldError < ValidationError; end

# Errores de respuesta HTTP 4XX
class ResponseError < ApplicationError; end
class BadRequestError < ResponseError; end
class UnauthorizedError < ResponseError; end
