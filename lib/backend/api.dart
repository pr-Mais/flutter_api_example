// class API {
//   const API();

//   static final String host = "programming-quotes-api.herokuapp.com";
//   static final String basePath = "/quotes";
//   Uri endpointUri(Endpoint endpoint) =>
//       Uri(scheme: "https", host: host, path: "$basePath/${_path[endpoint]}");
// }

// enum Endpoint {
//   random,
//   all,
// }

// Map<Endpoint, String> _path = {
//   Endpoint.random: "random/lang/en",
//   Endpoint.all: "lang/en"
// };

class API {
  const API();

  static final String host = "programming-quotes-api.herokuapp.com";
  static final String basePath = "/quotes";

  Uri endpointUri(Endpoint endpoint) => Uri(scheme: "https", host: host, path: "$basePath/${_path[endpoint]}");
}

Map<Endpoint, String> _path = {
  Endpoint.all: "lang/en",
  Endpoint.random: "random/lang/en",
};

enum Endpoint {
  all,
  random,
}