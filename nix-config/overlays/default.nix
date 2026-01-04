[
  (final: prev: {
    mongosh-bin = prev.stdenv.mkDerivation rec {
      pname = "mongosh-bin";
      version = "2.2.6";

      src = prev.fetchurl {
        url = "https://github.com/mongodb-js/mongosh/releases/download/v${version}/mongosh-${version}-linux-x64.tgz";
        sha256 = "M2cCibhis3ciFT3Wmp/5FwcdPwJANqllEswM2XWdrRA=";
      };

      sourceRoot = ".";

      installPhase = ''
        tar -xzf ${src}
        mkdir -p $out/bin
        cp -r mongosh-2.2.6-linux-x64/bin/* $out/bin/
      '';

      meta = with prev.lib; {
        description = "MongoDB Shell (binary release)";
        homepage = "https://www.mongodb.com/products/shell";
        license = licenses.asl20;
        platforms = [ "x86_64-linux" ];
      };
    };
  })
]