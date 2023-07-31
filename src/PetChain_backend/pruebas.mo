import Buffer "mo:base/Buffer";
import TrieSet "mo:base/TrieSet";
import Text "mo:base/Text";

actor{

    func isNotNull<T>(x: ?T): (Bool){ //funcion que devuelve algo y no es async
        return switch x{
            case null{false};
            case _{true};
        };
    };

    public func arrayToSet(x: [Text]):async [Text]{
        var set = TrieSet.fromArray(x, Text.hash, Text.equal);
        return TrieSet.toArray(set);
    }


}
