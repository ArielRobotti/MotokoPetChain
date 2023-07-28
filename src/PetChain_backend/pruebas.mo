import Buffer "mo:base/Buffer";

actor{

    func isNotNull<T>(x: ?T): (Bool){ //funcion que devuelve algo y no es async
        return switch x{
            case null{false};
            case _{true};
        };
    }


}
