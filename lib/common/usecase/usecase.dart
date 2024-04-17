abstract class Usecase<R, Params> {
  R execute(Params params);
}

class NoParams {}
