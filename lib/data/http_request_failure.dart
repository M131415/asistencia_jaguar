

/// Represents common HTTP request failures with their corresponding status codes
enum HttpRequestFailure {
  badRequest(400, 'Mala solicitud'),
  unauthorized(401, 'No autorizado'),
  forbidden(403, 'No tiene acceso a este recurso'),
  notFound(404, 'Recurso no encontrado'),
  methodNotAllowed(405, 'Método no permitido'),
  conflict(409, 'Conflicto'),
  payloadTooLarge(413, 'Carga útil demasiado grande'), 
  unprocessableEntity(422, 'Entidad no procesable'),
  tooManyRequests(429, 'Demasiadas solicitudes'),
  internalServerError(500, 'Error interno del servidor'),
  notImplemented(501, 'No implementado'),
  badGateway(502, 'Puerta de enlace incorrecta'),
  serviceUnavailable(503, 'Servicio no disponible'),
  gatewayTimeout(504, 'Tiempo de espera de la puerta de enlace excedido'),
  unknown(-1, 'Error desconocido'),
  network(-2, 'Error de red, revise su conexión'),
  local(-3, 'Error local');

  const HttpRequestFailure(this.statusCode, this.message);
  final int statusCode;
  final String message;

  /// Returns true if the status code represents a server error (5xx)
  bool get isServerError => statusCode >= 500 && statusCode < 600;

  /// Returns true if the status code represents a client error (4xx)
  bool get isClientError => statusCode >= 400 && statusCode < 500;
}