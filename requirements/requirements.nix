# generated using pypi2nix tool (version: 1.8.1)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -r frozen.txt -e pbr -V 3.5 -E postgresql libffi libxml2 libxslt openldap cyrus_sasl openssl ncurses -v --default-overrides
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python35;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = old.patchPhase + ''
            if [ -e $out/${pkgs.python35.sitePackages}/pip/req/req_install.py ]; then
              sed -i \
                -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"  \
                -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"  \
                $out/${pkgs.python35.sitePackages}/pip/req/req_install.py
            fi
          '';
        });
      };
  };

  commonBuildInputs = with pkgs; [ postgresql libffi libxml2 libxslt openldap cyrus_sasl openssl ncurses ];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreterWithPackages = selectPkgsFn: pythonPackages.buildPythonPackage {
        name = "python35-interpreter";
        buildInputs = [ makeWrapper ] ++ (selectPkgsFn pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (selectPkgsFn pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable} \
              python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };

      interpreter = interpreterWithPackages builtins.attrValues;
    in {
      __old = pythonPackages;
      inherit interpreter;
      inherit interpreterWithPackages;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (
          drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; }
        );
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {
    "Jinja2" = python.mkDerivation {
      name = "Jinja2-2.10";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/56/e6/332789f295cf22308386cf5bbd1f4e00ed11484299c5d7383378cf48ba47/Jinja2-2.10.tar.gz"; sha256 = "f84be1bb0040caca4cea721fcbbbbd61f9be9464ca236387158b0feea01914a4"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."MarkupSafe"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://jinja.pocoo.org/";
        license = licenses.bsdOriginal;
        description = "A small but fast and easy to use stand-alone template engine written in pure python.";
      };
    };

    "MarkupSafe" = python.mkDerivation {
      name = "MarkupSafe-1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz"; sha256 = "a6be69091dac236ea9c6bc7d012beab42010fa914c459791d627dad4910eb665"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/pallets/markupsafe";
        license = licenses.bsdOriginal;
        description = "Implements a XML/HTML/XHTML Markup safe string for Python";
      };
    };

    "PasteDeploy" = python.mkDerivation {
      name = "PasteDeploy-1.5.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/0f/90/8e20cdae206c543ea10793cbf4136eb9a8b3f417e04e40a29d72d9922cbd/PasteDeploy-1.5.2.tar.gz"; sha256 = "d5858f89a255e6294e63ed46b73613c56e3b9a2d82a42f1df4d06c8421a9e3cb"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonpaste.org/deploy/";
        license = licenses.mit;
        description = "Load, configure, and compose WSGI applications and servers";
      };
    };

    "PyBrowserID" = python.mkDerivation {
      name = "PyBrowserID-0.14.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e4/2e/e9bb9e24e600da08ff6a4d003362434eed717151f58413d8f73427e7e315/PyBrowserID-0.14.0.tar.gz"; sha256 = "6c227669e87cc25796ae76f6a0ef65025528c8ad82d352679fa9a3e5663a71e3"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mozilla/PyBrowserID";
        license = licenses.mpl20;
        description = "Python library for the BrowserID Protocol";
      };
    };

    "PyFxA" = python.mkDerivation {
      name = "PyFxA-0.6.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/42/dc/98b3709cdbc02c49afd27449adf16c8ee80c37df8f8cdbb5eb071ddc2200/PyFxA-0.6.0.tar.gz"; sha256 = "d511b6f43a9445587c609a138636d378de76661561116e1f4259fcec9d09b42b"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyBrowserID"
      self."cryptography"
      self."hawkauthlib"
      self."requests"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mozilla/PyFxA";
        license = licenses.mpl20;
        description = "Firefox Accounts client library for Python";
      };
    };

    "SQLAlchemy" = python.mkDerivation {
      name = "SQLAlchemy-1.2.8";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b4/9c/411a9bac1a471bed54ec447dc183aeed12a75c1b648307e18b56e3829363/SQLAlchemy-1.2.8.tar.gz"; sha256 = "2d5f08f714a886a1382c18be501e614bce50d362384dc089474019ce0768151c"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."psycopg2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.sqlalchemy.org";
        license = licenses.mit;
        description = "Database Abstraction Library";
      };
    };

    "Unidecode" = python.mkDerivation {
      name = "Unidecode-1.0.22";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9d/36/49d0ee152b6a1631f03a541532c6201942430060aa97fe011cf01a2cce64/Unidecode-1.0.22.tar.gz"; sha256 = "8c33dd588e0c9bc22a76eaa0c715a5434851f726131bd44a6c26471746efabf5"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.gpl2Plus;
        description = "ASCII transliterations of Unicode text";
      };
    };

    "WebOb" = python.mkDerivation {
      name = "WebOb-1.8.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f2/8a/dd4a3a32fba184e48a50be732aa390f9db2a725a535dcfb9fee781a2943c/WebOb-1.8.2.tar.gz"; sha256 = "1fe722f2ab857685fc96edec567dc40b1875b21219b3b348e58cd8c4d5ea7df3"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://webob.org/";
        license = licenses.mit;
        description = "WSGI request and response object";
      };
    };

    "Werkzeug" = python.mkDerivation {
      name = "Werkzeug-0.14.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9f/08/a3bb1c045ec602dc680906fc0261c267bed6b3bb4609430aff92c3888ec8/Werkzeug-0.14.1.tar.gz"; sha256 = "c3fd7a7d41976d9f44db327260e263132466836cef6f91512889ed60ad26557c"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.palletsprojects.org/p/werkzeug/";
        license = licenses.bsdOriginal;
        description = "The comprehensive WSGI web application library.";
      };
    };

    "amo2kinto" = python.mkDerivation {
      name = "amo2kinto-4.0.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/c2/bf/dd61c9cd2b19fa0bd8b0445d9d72d7144950a8bfbfd2105dc018fe15a294/amo2kinto-4.0.1.tar.gz"; sha256 = "955f8c44c33077d27c8e9593f1fdb5826445e212fd5add87788ca4c2a70baeab"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Jinja2"
      self."kinto-http"
      self."lxml"
      self."python-dateutil"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mozilla-services/amo2kinto";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Generate a blocklists.xml file from the Kinto collections.";
      };
    };

    "asn1crypto" = python.mkDerivation {
      name = "asn1crypto-0.24.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/fc/f1/8db7daa71f414ddabfa056c4ef792e1461ff655c2ae2928a2b675bfed6b4/asn1crypto-0.24.0.tar.gz"; sha256 = "9d5c20441baf0cb60a4ac34cc447c6c189024b6b4c6cd7877034f4965c464e49"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/wbond/asn1crypto";
        license = licenses.mit;
        description = "Fast ASN.1 parser and serializer with definitions for private keys, public keys, certificates, CRL, OCSP, CMS, PKCS#3, PKCS#7, PKCS#8, PKCS#12, PKCS#5, X.509 and TSP";
      };
    };

    "bcrypt" = python.mkDerivation {
      name = "bcrypt-3.1.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f3/ec/bb6b384b5134fd881b91b6aa3a88ccddaad0103857760711a5ab8c799358/bcrypt-3.1.4.tar.gz"; sha256 = "67ed1a374c9155ec0840214ce804616de49c3df9c5bc66740687c1c9b1cd9e8d"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."cffi"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/bcrypt/";
        license = licenses.asl20;
        description = "Modern password hashing for your software and your servers";
      };
    };

    "boto" = python.mkDerivation {
      name = "boto-2.48.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/66/e7/fe1db6a5ed53831b53b8a6695a8f134a58833cadb5f2740802bc3730ac15/boto-2.48.0.tar.gz"; sha256 = "deb8925b734b109679e3de65856018996338758f4b916ff4fe7bb62b6d7000d1"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/boto/";
        license = licenses.mit;
        description = "Amazon Web Services Library";
      };
    };

    "boto3" = python.mkDerivation {
      name = "boto3-1.7.46";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/26/07/acf8ea5376ba894fed7d7ce8558ea998871deb98c790bfaf1a79c40b537b/boto3-1.7.46.tar.gz"; sha256 = "bf69f95011241bf25adfb9db0f0fee5810c4145695c9b7d64ef6328a759f9a63"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."botocore"
      self."jmespath"
      self."s3transfer"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/boto3";
        license = licenses.asl20;
        description = "The AWS SDK for Python";
      };
    };

    "botocore" = python.mkDerivation {
      name = "botocore-1.10.46";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/15/39/e62eaab66c55ead2f368212d9e973ce1d743143310927d06a7890c831789/botocore-1.10.46.tar.gz"; sha256 = "95aceceb5c267e705934122c1687d8d0f841a387da8a7c6c497b13ec20e35f24"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."docutils"
      self."jmespath"
      self."python-dateutil"
      self."simplejson"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/botocore";
        license = licenses.asl20;
        description = "Low-level, data-driven core of boto 3.";
      };
    };

    "certifi" = python.mkDerivation {
      name = "certifi-2018.4.16";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/4d/9c/46e950a6f4d6b4be571ddcae21e7bc846fcbb88f1de3eff0f6dd0a6be55d/certifi-2018.4.16.tar.gz"; sha256 = "13e698f54293db9f89122b0581843a782ad0934a4fe0172d2a980ba77fc61bb7"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://certifi.io/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };

    "cffi" = python.mkDerivation {
      name = "cffi-1.11.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e7/a7/4cd50e57cc6f436f1cc3a7e8fa700ff9b8b4d471620629074913e3735fb2/cffi-1.11.5.tar.gz"; sha256 = "e90f17980e6ab0f3c2f3730e56d1fe9bcba1891eeea58966e89d352492cc74f4"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pycparser"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cffi.readthedocs.org";
        license = licenses.mit;
        description = "Foreign Function Interface for Python calling C code.";
      };
    };

    "chardet" = python.mkDerivation {
      name = "chardet-3.0.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"; sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl2;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "colander" = python.mkDerivation {
      name = "colander-1.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/cc/e2/c4e716ac4a426d8ad4dfe306c34f0018a22275d2420815784005bf771c84/colander-1.4.tar.gz"; sha256 = "e20e9acf190e5711cf96aa65a5405dac04b6e841028fc361d953a9923dbc4e72"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."docutils"
      self."iso8601"
      self."translationstring"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docs.pylonsproject.org/projects/colander/en/latest/";
        license = "BSD-derived (http://www.repoze.org/LICENSE.txt)";
        description = "A simple schema-based serialization and deserialization library";
      };
    };

    "colorama" = python.mkDerivation {
      name = "colorama-0.3.9";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e6/76/257b53926889e2835355d74fec73d82662100135293e17d382e2b74d1669/colorama-0.3.9.tar.gz"; sha256 = "48eb22f4f8461b1df5734a074b57042430fb06e1d61bd1e11b078c0fe6d7a1f1"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/tartley/colorama";
        license = licenses.bsdOriginal;
        description = "Cross-platform colored terminal text.";
      };
    };

    "cornice" = python.mkDerivation {
      name = "cornice-3.4.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/5b/5f/940ac3feac30e9834f8cb0dd3e3c776d5ea1d983a45da723d553c8989f36/cornice-3.4.0.tar.gz"; sha256 = "5833582e7ff74ad6fe059bd22792cfeaff85aa0e2c37402b4adb0ae673d78ef7"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pyramid"
      self."simplejson"
      self."six"
      self."venusian"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mozilla-services/cornice";
        license = licenses.mpl20;
        description = "Define Web Services in Pyramid.";
      };
    };

    "cornice-swagger" = python.mkDerivation {
      name = "cornice-swagger-0.6.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/61/b5/ce0a21f8a489846fcae10512e947afa1a7e1a777c5b50fd32f9229d0dbc9/cornice_swagger-0.6.0.tar.gz"; sha256 = "22fc8de7a5b3b51268b847fcd1f58dbd50a0502e195cd8116b2956043dacfb7d"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."colander"
      self."cornice"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Cornices/cornice.ext.swagger";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Generate swagger from a Cornice application";
      };
    };

    "cryptography" = python.mkDerivation {
      name = "cryptography-2.2.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ec/b2/faa78c1ab928d2b2c634c8b41ff1181f0abdd9adf9193211bd606ffa57e2/cryptography-2.2.2.tar.gz"; sha256 = "9fc295bf69130a342e7a19a39d7bbeb15c0bcaabc7382ec33ef3b2b7d18d2f63"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."asn1crypto"
      self."cffi"
      self."idna"
      self."iso8601"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/cryptography";
        license = licenses.bsdOriginal;
        description = "cryptography is a package which provides cryptographic recipes and primitives to Python developers.";
      };
    };

    "dockerflow" = python.mkDerivation {
      name = "dockerflow-2018.4.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/20/43/0b4a2695447c53cb3c155820fdfb4cb89a8e0d4493fdf2c394ff9b70c118/dockerflow-2018.4.0.tar.gz"; sha256 = "2ea52a904abfda3430ff4f1effc164863b30d2b69f7ecbf92dd672860b0ec423"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mozilla-services/python-dockerflow";
        license = licenses.mpl20;
        description = "Python tools and helpers for Mozilla's Dockerflow";
      };
    };

    "docutils" = python.mkDerivation {
      name = "docutils-0.14";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/84/f4/5771e41fdf52aabebbadecc9381d11dea0fa34e4759b4071244fa094804c/docutils-0.14.tar.gz"; sha256 = "51e64ef2ebfb29cae1faa133b3710143496eca21c530f3f71424d77687764274"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docutils.sourceforge.net/";
        license = licenses.publicDomain;
        description = "Docutils -- Python Documentation Utilities";
      };
    };

    "ecdsa" = python.mkDerivation {
      name = "ecdsa-0.13";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f9/e5/99ebb176e47f150ac115ffeda5fedb6a3dbb3c00c74a59fd84ddf12f5857/ecdsa-0.13.tar.gz"; sha256 = "64cf1ee26d1cde3c73c6d7d107f835fed7c6a2904aef9eac223d57ad800c43fa"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/warner/python-ecdsa";
        license = licenses.mit;
        description = "ECDSA cryptographic signature library (pure python)";
      };
    };

    "elasticsearch" = python.mkDerivation {
      name = "elasticsearch-6.3.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/14/0f/08c478e6e9ae12e6e85b40953371bfbc98d523c0d0b8133ed501dfc9568f/elasticsearch-6.3.0.tar.gz"; sha256 = "80ff7a1a56920535a9987da333c7e385b2ded27595b6de33860707dab758efbe"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."requests"
      self."urllib3"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/elastic/elasticsearch-py";
        license = licenses.asl20;
        description = "Python client for Elasticsearch";
      };
    };

    "hawkauthlib" = python.mkDerivation {
      name = "hawkauthlib-2.0.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/26/b7/0ec2846e5e2b3591ca867d7b06b67b5242f73bfe6da164b7232b8bffc657/hawkauthlib-2.0.0.tar.gz"; sha256 = "effd64a2572e3c0d9090b55ad2180b36ad50e7760bea225cb6ce2248f421510d"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."WebOb"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mozilla-services/hawkauthlib";
        license = licenses.mpl20;
        description = "Hawk Access Authentication protocol";
      };
    };

    "hupper" = python.mkDerivation {
      name = "hupper-1.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/51/0c/96335b1f2f32245fb871eea5bb9773196505ddb71fad15190056a282df9e/hupper-1.3.tar.gz"; sha256 = "20387760e4d32bd4813c2cabc8e51d92b2c22c546102a0af182c33c152cd7ede"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Pylons/hupper";
        license = licenses.mit;
        description = "Integrated process monitor for developing and reloading daemons.";
      };
    };

    "idna" = python.mkDerivation {
      name = "idna-2.7";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/65/c4/80f97e9c9628f3cac9b98bfca0402ede54e0563b56482e3e6e45c43c4935/idna-2.7.tar.gz"; sha256 = "684a38a6f903c1d71d6d5fac066b58d7768af4de2b832e426ec79c30daa94a16"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "iso8601" = python.mkDerivation {
      name = "iso8601-0.1.12";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/45/13/3db24895497345fb44c4248c08b16da34a9eb02643cea2754b21b5ed08b0/iso8601-0.1.12.tar.gz"; sha256 = "49c4b20e1f38aa5cf109ddcd39647ac419f928512c869dc01d5c7098eddede82"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/micktwomey/pyiso8601";
        license = licenses.mit;
        description = "Simple module to parse ISO 8601 dates";
      };
    };

    "jmespath" = python.mkDerivation {
      name = "jmespath-0.9.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e5/21/795b7549397735e911b032f255cff5fb0de58f96da794274660bca4f58ef/jmespath-0.9.3.tar.gz"; sha256 = "6a81d4c9aa62caf061cb517b4d9ad1dd300374cd4706997aff9cd6aedd61fc64"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jmespath/jmespath.py";
        license = licenses.mit;
        description = "JSON Matching Expressions";
      };
    };

    "jsonpatch" = python.mkDerivation {
      name = "jsonpatch-1.23";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9a/7d/bcf203d81939420e1aaf7478a3efce1efb8ccb4d047a33cb85d7f96d775e/jsonpatch-1.23.tar.gz"; sha256 = "49f29cab70e9068db3b1dc6b656cbe2ee4edf7dfe9bf5a0055f17a4b6804a4b9"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."jsonpointer"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/stefankoegl/python-json-patch";
        license = licenses.bsdOriginal;
        description = "Apply JSON-Patches (RFC 6902) ";
      };
    };

    "jsonpointer" = python.mkDerivation {
      name = "jsonpointer-2.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/52/e7/246d9ef2366d430f0ce7bdc494ea2df8b49d7a2a41ba51f5655f68cfe85f/jsonpointer-2.0.tar.gz"; sha256 = "c192ba86648e05fdae4f08a17ec25180a9aef5008d973407b581798a83975362"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/stefankoegl/python-json-pointer";
        license = licenses.bsdOriginal;
        description = "Identify specific nodes in a JSON document (RFC 6901) ";
      };
    };

    "jsonschema" = python.mkDerivation {
      name = "jsonschema-2.6.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/58/b9/171dbb07e18c6346090a37f03c7e74410a1a56123f847efed59af260a298/jsonschema-2.6.0.tar.gz"; sha256 = "6ff5f3180870836cae40f06fa10419f557208175f13ad7bc26caa77beb1f6e02"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/Julian/jsonschema";
        license = licenses.mit;
        description = "An implementation of JSON Schema validation for Python";
      };
    };

    "kinto" = python.mkDerivation {
      name = "kinto-9.2.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ed/81/aa0e63adfcb8ed0365a10bd7a9d86b6c90c884ac522b8366d60c204bac61/kinto-9.2.3.tar.gz"; sha256 = "cf8bb489c0c37f456efa06b22f9016124497d70e82917c74b99d533432924124"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."SQLAlchemy"
      self."Werkzeug"
      self."bcrypt"
      self."colander"
      self."cornice"
      self."cornice-swagger"
      self."dockerflow"
      self."jsonpatch"
      self."jsonschema"
      self."logging-color-formatter"
      self."newrelic"
      self."psycopg2"
      self."pyramid"
      self."pyramid-multiauth"
      self."pyramid-tm"
      self."python-dateutil"
      self."python-memcached"
      self."raven"
      self."requests"
      self."statsd"
      self."transaction"
      self."ujson"
      self."waitress"
      self."zope.sqlalchemy"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Kinto/kinto";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Kinto Web Service - Store, Sync, Share, and Self-Host.";
      };
    };

    "kinto-amo" = python.mkDerivation {
      name = "kinto-amo-1.0.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/c0/99/1376dfeabf28c9899a158f2d0d2799350c6ed8888a834b2202327b3e4975/kinto-amo-1.0.1.tar.gz"; sha256 = "5601bc1f0d8c71f12b89862d3c82bcca4380b3fec8824919b01b6e52bbed6d69"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."amo2kinto"
      self."kinto"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mozilla-services/kinto-amo";
        license = "License :: OSI Approved :: Apache Software License";
        description = "AMO-style routing for Kinto - with XML";
      };
    };

    "kinto-attachment" = python.mkDerivation {
      name = "kinto-attachment-4.0.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f3/45/7640351cefd5c5f0487ee6eaa80f3af2a7465085a841aa55ea311554a56a/kinto-attachment-4.0.0.tar.gz"; sha256 = "80fb4b932e092a34c867e9b52a45725830282d6bebe0b9e5eb388fccc673081e"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."boto"
      self."kinto"
      self."pyramid-storage"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Kinto/kinto-attachment";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Attach files to Kinto records";
      };
    };

    "kinto-changes" = python.mkDerivation {
      name = "kinto-changes-1.1.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/5b/aa/77579e77c5f5214894dba174f94daa6e11ba8ed3dcb0064c864486d120bd/kinto-changes-1.1.1.tar.gz"; sha256 = "0ceffb09fa65639d2136912bf7828486cfad89f6f815a910e2bb8daf2492e4d7"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."kinto"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kinto/kinto-changes";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Plug Kinto notifications to a collection endpoint.";
      };
    };

    "kinto-elasticsearch" = python.mkDerivation {
      name = "kinto-elasticsearch-0.3.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f2/ac/76648f2d37981afbfc462ad41744f503a02b98965617cb969687f8111e2e/kinto-elasticsearch-0.3.1.tar.gz"; sha256 = "0315227738cf08fbe532330bc4fac9c963e4b688041de6fc042be04af7597870"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."elasticsearch"
      self."kinto"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kinto/kinto-elasticsearch";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Index and search records using ElasticSearch.";
      };
    };

    "kinto-emailer" = python.mkDerivation {
      name = "kinto-emailer-1.0.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/d6/44/bf972d809e4253d742601a007abb8051d901fa7e593b443db90b816eadfe/kinto-emailer-1.0.2.tar.gz"; sha256 = "a0552a8fa8c749595d745aeb7ccbe0c60cef660588af1e4d6e1b4e9051eb7707"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."kinto"
      self."pyramid-mailer"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Kinto/kinto-emailer";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Kinto emailer plugin";
      };
    };

    "kinto-fxa" = python.mkDerivation {
      name = "kinto-fxa-2.5.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/7d/84/8662667f70dfce05741246e2b7e2bbff148f798cb47e75619b07076d4499/kinto-fxa-2.5.2.tar.gz"; sha256 = "3c16b053ba835d2190bdaabd2018f824f624849369b4dfe53097ed4a4e466cb6"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyFxA"
      self."SQLAlchemy"
      self."boto3"
      self."kinto"
      self."psycopg2"
      self."zope.sqlalchemy"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Kinto/kinto-fxa";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Firefox Accounts support in Kinto";
      };
    };

    "kinto-http" = python.mkDerivation {
      name = "kinto-http-9.1.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/65/ef/614d0baa2ca8a0ebd606b97026af9493d24f61bf8afdd4fafdbcdf458279/kinto-http-9.1.2.tar.gz"; sha256 = "dce1d39bad5b7323b43a2e8c8116b2dd02706e4dfa9d1554d4e573cdb9e08f01"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Unidecode"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Kinto/kinto-http.py/";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Kinto client";
      };
    };

    "kinto-ldap" = python.mkDerivation {
      name = "kinto-ldap-0.3.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b9/d6/076274eee0a976b3e1de35e46faf9812c9473ca27fc3b015713d72c5a3e9/kinto-ldap-0.3.1.tar.gz"; sha256 = "bb700ef7f438cfa1212b84bfa3751dc831ee5d88f163077cfc33707324b433b4"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."kinto"
      self."ldappool"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Kinto/kinto-ldap";
        license = "License :: OSI Approved :: Apache Software License";
        description = "LDAP support for Kinto";
      };
    };

    "kinto-signer" = python.mkDerivation {
      name = "kinto-signer-3.3.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e4/3a/6c7370cc10fb8cb82bc82aee2bfc25a6bd04173071710009e7475be62932/kinto-signer-3.3.0.tar.gz"; sha256 = "b794a646104461173d54e8fa819a4a4d8eff9613de428472a233f383cbd0d2a0"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."boto3"
      self."ecdsa"
      self."kinto"
      self."requests-hawk"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Kinto signer";
      };
    };

    "ldappool" = python.mkDerivation {
      name = "ldappool-2.2.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/5b/2e/7e73ca450775283c8ba27b4517bcc48a4e0f170cf2fb93df59d1af02c54c/ldappool-2.2.0.tar.gz"; sha256 = "c97390692cd77dbb483957abd90b5bf18259602ac53a1bc58e5c493de36d760d"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pyldap"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://git.openstack.org/cgit/openstack/ldappool";
        license = licenses.mpl20;
        description = "A simple connector pool for python-ldap.";
      };
    };

    "logging-color-formatter" = python.mkDerivation {
      name = "logging-color-formatter-1.0.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/84/63/37b055040d257aba4a250cfff8fcb042944ab1bc6930bc286df7655b7b86/logging-color-formatter-1.0.2.tar.gz"; sha256 = "a115c04ebd0be5dc511f71a44dbad531e5b7cb91b91d3924982d69dff0333ad4"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."colorama"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/leplatrem/logging-color-formatter";
        license = "Apache License (2.0)";
        description = "A colored logging formatter";
      };
    };

    "lxml" = python.mkDerivation {
      name = "lxml-4.2.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/54/a6/43be8cf1cc23e3fa208cab04ba2f9c3b7af0233aab32af6b5089122b44cd/lxml-4.2.3.tar.gz"; sha256 = "622f7e40faef13d232fb52003661f2764ce6cdef3edb0a59af7c1559e4cc36d1"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://lxml.de/";
        license = licenses.bsdOriginal;
        description = "Powerful and Pythonic XML processing library combining libxml2/libxslt with the ElementTree API.";
      };
    };

    "mohawk" = python.mkDerivation {
      name = "mohawk-0.3.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/19/22/10f696548a8d41ad41b92ab6c848c60c669e18c8681c179265ce4d048b03/mohawk-0.3.4.tar.gz"; sha256 = "e98b331d9fa9ece7b8be26094cbe2d57613ae882133cc755167268a984bc0ab3"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kumar303/mohawk";
        license = licenses.mpl20;
        description = "Library for Hawk HTTP authorization";
      };
    };

    "newrelic" = python.mkDerivation {
      name = "newrelic-3.2.2.94";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f4/4e/5a69f47b921b391176c93c3b2fd48a2deecbc888a8c27b9caf68bfc0c3be/newrelic-3.2.2.94.tar.gz"; sha256 = "916f96ded421efa1c5f97d24fa4131cce513039b6e875ccbd090b852dddc104e"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://newrelic.com/docs/python/new-relic-for-python";
        license = "License :: Other/Proprietary License";
        description = "New Relic Python Agent";
      };
    };

    "pbr" = python.mkDerivation {
      name = "pbr-4.2.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/c8/c3/935b102539529ea9e6dcf3e8b899583095a018b09f29855ab754a2012513/pbr-4.2.0.tar.gz"; sha256 = "1b8be50d938c9bb75d0eaf7eda111eec1bf6dc88a62a6412e33bf077457e0f45"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.openstack.org/pbr/latest/";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Python Build Reasonableness";
      };
    };

    "plaster" = python.mkDerivation {
      name = "plaster-1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/37/e1/56d04382d718d32751017d32f351214384e529b794084eee20bb52405563/plaster-1.0.tar.gz"; sha256 = "8351c7c7efdf33084c1de88dd0f422cbe7342534537b553c49b857b12d98c8c3"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.pylonsproject.org/projects/plaster/en/latest/";
        license = licenses.mit;
        description = "A loader interface around multiple config file formats.";
      };
    };

    "plaster-pastedeploy" = python.mkDerivation {
      name = "plaster-pastedeploy-0.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e7/05/cc12d9d3efaa10046b6ec5de91b16486c95de4847dc57599bf58021a3d5c/plaster_pastedeploy-0.5.tar.gz"; sha256 = "70a3185b2a3336996a26e9987968cf35e84cf13390b7e8a0a9a91eb8f6f85ba9"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PasteDeploy"
      self."plaster"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Pylons/plaster_pastedeploy";
        license = licenses.mit;
        description = "A loader implementing the PasteDeploy syntax to be used by plaster.";
      };
    };

    "psycopg2" = python.mkDerivation {
      name = "psycopg2-2.7.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b2/c1/7bf6c464e903ffc4f3f5907c389e5a4199666bf57f6cd6bf46c17912a1f9/psycopg2-2.7.5.tar.gz"; sha256 = "eccf962d41ca46e6326b97c8fe0a6687b58dfc1a5f6540ed071ff1474cea749e"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://initd.org/psycopg/";
        license = licenses.lgpl2;
        description = "psycopg2 - Python-PostgreSQL Database Adapter";
      };
    };

    "pyasn1" = python.mkDerivation {
      name = "pyasn1-0.4.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/0d/33/3466a3210321a02040e3ab2cd1ffc6f44664301a5d650a7e44be1dc341f2/pyasn1-0.4.3.tar.gz"; sha256 = "fb81622d8f3509f0026b0683fe90fea27be7284d3826a5f2edf97f69151ab0fc"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/etingof/pyasn1";
        license = licenses.bsdOriginal;
        description = "ASN.1 types and codecs";
      };
    };

    "pyasn1-modules" = python.mkDerivation {
      name = "pyasn1-modules-0.2.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ab/76/36ab0e099e6bd27ed95b70c2c86c326d3affa59b9b535c63a2f892ac9f45/pyasn1-modules-0.2.1.tar.gz"; sha256 = "af00ea8f2022b6287dc375b2c70f31ab5af83989fc6fe9eacd4976ce26cd7ccc"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pyasn1"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/etingof/pyasn1-modules";
        license = licenses.bsdOriginal;
        description = "A collection of ASN.1-based protocols modules.";
      };
    };

    "pycparser" = python.mkDerivation {
      name = "pycparser-2.18";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/8c/2d/aad7f16146f4197a11f8e91fb81df177adcc2073d36a17b1491fd09df6ed/pycparser-2.18.tar.gz"; sha256 = "99a8ca03e29851d96616ad0404b4aad7d9ee16f25c9f9708a11faf2810f7b226"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/eliben/pycparser";
        license = licenses.bsdOriginal;
        description = "C parser in Python";
      };
    };

    "pyldap" = python.mkDerivation {
      name = "pyldap-3.0.0.post1";
      src = pkgs.fetchurl { url = "https://github.com/pyldap/pyldap/archive/python-ldap-3.0.0.post1.tar.gz"; sha256 = "4379640f9c09fa0331044624608284f6752faec1959cb4a04ad675a4fb715774"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."python-ldap"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyldap/pyldap/";
        license = "Python style";
        description = "DEPRECATED; use python-ldap instead";
      };
    };

    "pyramid" = python.mkDerivation {
      name = "pyramid-1.9.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a0/c1/b321d07cfc4870541989ad131c86a1d593bfe802af0eca9718a0dadfb97a/pyramid-1.9.2.tar.gz"; sha256 = "cf89a48cb899291639686bf3d4a883b39e496151fa4871fb83cc1a3200d5b925"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PasteDeploy"
      self."WebOb"
      self."docutils"
      self."hupper"
      self."plaster"
      self."plaster-pastedeploy"
      self."repoze.lru"
      self."translationstring"
      self."venusian"
      self."virtualenv"
      self."zope.deprecation"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://trypyramid.com";
        license = "License :: Repoze Public License";
        description = "The Pyramid Web Framework, a Pylons project";
      };
    };

    "pyramid-mailer" = python.mkDerivation {
      name = "pyramid-mailer-0.15.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a0/f2/6febf5459dff4d7e653314d575469ad2e11b9d2af2c3606360e1c67202f2/pyramid_mailer-0.15.1.tar.gz"; sha256 = "ec0aff54d9179b2aa2922ff82c2016a4dc8d1da5dc3408d6594f0e2096446f9b"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."docutils"
      self."pyramid"
      self."repoze.sendmail"
      self."transaction"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docs.pylonsproject.org/projects/pyramid-mailer/en/latest/";
        license = licenses.bsdOriginal;
        description = "Sendmail package for Pyramid";
      };
    };

    "pyramid-multiauth" = python.mkDerivation {
      name = "pyramid-multiauth-0.9.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/6e/ab/d92fb9ffffca78f79ca1d0b13bccc25bedf108a282127ad02589dcf657cf/pyramid_multiauth-0.9.0.tar.gz"; sha256 = "3eda2a01de867ce8e68e8f0f410a7b51be68891e34dc31808992fdf1bcc4f952"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pyramid"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mozilla-services/pyramid_multiauth";
        license = licenses.mpl20;
        description = "pyramid_multiauth";
      };
    };

    "pyramid-storage" = python.mkDerivation {
      name = "pyramid-storage-0.1.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/05/31/df7c4dca7bc1d7a6dc6fd92bf6764a14abd0745d2d966e64b789377cd2a7/pyramid_storage-0.1.2.tar.gz"; sha256 = "f9d381492b7b74fa2020db27e7a5b70fd0f1b130aabe9df4dc4c83f884aac978"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."docutils"
      self."pyramid"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "File storage package for Pyramid";
      };
    };

    "pyramid-tm" = python.mkDerivation {
      name = "pyramid-tm-2.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9e/66/048cc82262e93fcca4f2bcf448723028f3848f21411438127ee0cfa074ac/pyramid_tm-2.2.tar.gz"; sha256 = "07d03bab7bdd265c3920db4e68dbaa8cbaff27da828700f404b1424244ad617f"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pyramid"
      self."transaction"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docs.pylonsproject.org/projects/pyramid-tm/en/latest/";
        license = "License :: Repoze Public License";
        description = "A package which allows Pyramid requests to join the active transaction";
      };
    };

    "python-dateutil" = python.mkDerivation {
      name = "python-dateutil-2.7.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a0/b0/a4e3241d2dee665fea11baec21389aec6886655cd4db7647ddf96c3fad15/python-dateutil-2.7.3.tar.gz"; sha256 = "e27001de32f627c22380a688bcc43ce83504a7bc5da472209b4c70f02829f0b8"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://dateutil.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "Extensions to the standard Python datetime module";
      };
    };

    "python-ldap" = python.mkDerivation {
      name = "python-ldap-3.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/7f/1c/28d721dff2fcd2fef9d55b40df63a00be26ec8a11e8c6fc612ae642f9cfd/python-ldap-3.1.0.tar.gz"; sha256 = "41975e79406502c092732c57ef0c2c2eb318d91e8e765f81f5d4ab6c1db727c5"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pyasn1"
      self."pyasn1-modules"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.python-ldap.org/";
        license = licenses.psfl;
        description = "Python modules for implementing LDAP clients";
      };
    };

    "python-memcached" = python.mkDerivation {
      name = "python-memcached-1.59";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/90/59/5faf6e3cd8a568dd4f737ddae4f2e54204fd8c51f90bf8df99aca6c22318/python-memcached-1.59.tar.gz"; sha256 = "a2e28637be13ee0bf1a8b6843e7490f9456fd3f2a4cb60471733c7b5d5557e4f"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/linsomniac/python-memcached";
        license = licenses.psfl;
        description = "Pure python memcached client";
      };
    };

    "raven" = python.mkDerivation {
      name = "raven-6.9.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/8f/80/e8d734244fd377fd7d65275b27252642512ccabe7850105922116340a37b/raven-6.9.0.tar.gz"; sha256 = "3fd787d19ebb49919268f06f19310e8112d619ef364f7989246fc8753d469888"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."WebOb"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/getsentry/raven-python";
        license = licenses.bsdOriginal;
        description = "Raven is a client for Sentry (https://getsentry.com)";
      };
    };

    "repoze.lru" = python.mkDerivation {
      name = "repoze.lru-0.7";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/12/bc/595a77c4b5e204847fdf19268314ef59c85193a9dc9f83630fc459c0fee5/repoze.lru-0.7.tar.gz"; sha256 = "0429a75e19380e4ed50c0694e26ac8819b4ea7851ee1fc7583c8572db80aff77"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.repoze.org";
        license = "License :: Repoze Public License";
        description = "A tiny LRU cache implementation and decorator";
      };
    };

    "repoze.sendmail" = python.mkDerivation {
      name = "repoze.sendmail-4.4.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/12/4e/8ef1fd5c42765d712427b9c391419a77bd48877886d2cbc5e9f23c8cad9b/repoze.sendmail-4.4.1.tar.gz"; sha256 = "7a8ea37914a5d38bad38052a83eac1d867b171ff4cc8b4d4994e892c05b0d424"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."transaction"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.repoze.org";
        license = licenses.zpl21;
        description = "Repoze Sendmail";
      };
    };

    "requests" = python.mkDerivation {
      name = "requests-2.19.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/54/1f/782a5734931ddf2e1494e4cd615a51ff98e1879cbe9eecbdfeaf09aa75e9/requests-2.19.1.tar.gz"; sha256 = "ec22d826a36ed72a7358ff3fe56cbd4ba69dd7a6718ffd450ff0e9df7a47ce6a"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."certifi"
      self."chardet"
      self."cryptography"
      self."idna"
      self."urllib3"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://python-requests.org";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };

    "requests-hawk" = python.mkDerivation {
      name = "requests-hawk-1.0.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/8a/62/e89d4e23847f74f56c66a0ae76c17e356338a0fe7bd352842647f5877a07/requests-hawk-1.0.0.tar.gz"; sha256 = "aef0dff8053dcae2057774516386bed0a3bc03fabea9e18f3aa98f02672ea5d0"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."mohawk"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mozilla-services/requests-hawk";
        license = "License :: OSI Approved :: Apache Software License";
        description = "requests-hawk";
      };
    };

    "s3transfer" = python.mkDerivation {
      name = "s3transfer-0.1.13";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9a/66/c6a5ae4dbbaf253bd662921b805e4972451a6d214d0dc9fb3300cb642320/s3transfer-0.1.13.tar.gz"; sha256 = "90dc18e028989c609146e241ea153250be451e05ecc0c2832565231dacdf59c1"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."botocore"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/boto/s3transfer";
        license = licenses.asl20;
        description = "An Amazon S3 Transfer Manager";
      };
    };

    "simplejson" = python.mkDerivation {
      name = "simplejson-3.15.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/8b/6c/c512c32124d1d2d67a32ff867bb3cdd5bfa6432660975f7ee753ed7ad886/simplejson-3.15.0.tar.gz"; sha256 = "ad332f65d9551ceffc132d0a683f4ffd12e4bc7538681100190d577ced3473fb"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/simplejson/simplejson";
        license = licenses.mit;
        description = "Simple, fast, extensible JSON encoder/decoder for Python";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.11.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"; sha256 = "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/six/";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "statsd" = python.mkDerivation {
      name = "statsd-3.2.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/48/5f/9b62d3edf46d4f781be77fcd5014ab6c8945c0c991f5a26628d7d5eaf69c/statsd-3.2.2.tar.gz"; sha256 = "84f2427ef7b8ffab28cdb717933f6889d248d710eee32b5eb79e3fdac0e374dd"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jsocol/pystatsd";
        license = licenses.mit;
        description = "A simple statsd client.";
      };
    };

    "transaction" = python.mkDerivation {
      name = "transaction-2.2.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a6/5e/09da91cb9373c73aae41721e5571c47db72fa9e11b259ca8fd3b01e306e9/transaction-2.2.1.tar.gz"; sha256 = "f2242070e437e5d555ea3df809cb517860513254c828f33847df1c5e4b776c7a"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zopefoundation/transaction";
        license = licenses.zpl21;
        description = "Transaction management for Python";
      };
    };

    "translationstring" = python.mkDerivation {
      name = "translationstring-1.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/5e/eb/bee578cc150b44c653b63f5ebe258b5d0d812ddac12497e5f80fcad5d0b4/translationstring-1.3.tar.gz"; sha256 = "4ee44cfa58c52ade8910ea0ebc3d2d84bdcad9fa0422405b1801ec9b9a65b72d"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pylonsproject.org";
        license = "BSD-like (http://repoze.org/license.html)";
        description = "Utility library for i18n relied on by various Repoze and Pyramid packages";
      };
    };

    "uWSGI" = python.mkDerivation {
      name = "uWSGI-2.0.17";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/98/b2/19b34b20662d111f7d2f926cdf10e13381761dd7dbd10666b9076cbdcd22/uwsgi-2.0.17.tar.gz"; sha256 = "3dc2e9b48db92b67bfec1badec0d3fdcc0771316486c5efa3217569da3528bf2"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://uwsgi-docs.readthedocs.io/en/latest/";
        license = "GPL2";
        description = "The uWSGI server";
      };
    };

    "ujson" = python.mkDerivation {
      name = "ujson-1.35";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/16/c4/79f3409bc710559015464e5f49b9879430d8f87498ecdc335899732e5377/ujson-1.35.tar.gz"; sha256 = "f66073e5506e91d204ab0c614a148d5aa938bdbf104751be66f8ad7a222f5f86"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.esn.me";
        license = licenses.bsdOriginal;
        description = "Ultra fast JSON encoder and decoder for Python";
      };
    };

    "urllib3" = python.mkDerivation {
      name = "urllib3-1.23";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/3c/d2/dc5471622bd200db1cd9319e02e71bc655e9ea27b8e0ce65fc69de0dac15/urllib3-1.23.tar.gz"; sha256 = "a68ac5e15e76e7e5dd2b8f94007233e01effe3e50e8daddf69acfd81cb686baf"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."certifi"
      self."cryptography"
      self."idna"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://urllib3.readthedocs.io/";
        license = licenses.mit;
        description = "HTTP library with thread-safe connection pooling, file post, and more.";
      };
    };

    "venusian" = python.mkDerivation {
      name = "venusian-1.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/38/24/b4b470ab9e0a2e2e9b9030c7735828c8934b4c6b45befd1bb713ec2aeb2d/venusian-1.1.0.tar.gz"; sha256 = "9902e492c71a89a241a18b2f9950bea7e41d025cc8f3af1ea8d8201346f8577d"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pylonsproject.org";
        license = "BSD-derived (http://www.repoze.org/LICENSE.txt)";
        description = "A library for deferring decorator actions";
      };
    };

    "virtualenv" = python.mkDerivation {
      name = "virtualenv-16.0.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/33/bc/fa0b5347139cd9564f0d44ebd2b147ac97c36b2403943dbee8a25fd74012/virtualenv-16.0.0.tar.gz"; sha256 = "ca07b4c0b54e14a91af9f34d0919790b016923d157afda5efdde55c96718f752"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://virtualenv.pypa.io/";
        license = licenses.mit;
        description = "Virtual Python Environment builder";
      };
    };

    "waitress" = python.mkDerivation {
      name = "waitress-1.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/3c/68/1c10dd5c556872ceebe88483b0436140048d39de83a84a06a8baa8136f4f/waitress-1.1.0.tar.gz"; sha256 = "d33cd3d62426c0f1b3cd84ee3d65779c7003aae3fc060dee60524d10a57f05a9"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."docutils"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Pylons/waitress";
        license = licenses.zpl21;
        description = "Waitress WSGI server";
      };
    };

    "zope.deprecation" = python.mkDerivation {
      name = "zope.deprecation-4.3.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a1/18/2dc5e6bfe64fdc3b79411b67464c55bb0b43b127051a20f7f492ab767758/zope.deprecation-4.3.0.tar.gz"; sha256 = "7d52e134bbaaa0d72e1e2bc90f0587f1adc116c4bdf15912afaf2f1e8856b224"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/zopefoundation/zope.deprecation";
        license = licenses.zpl21;
        description = "Zope Deprecation Infrastructure";
      };
    };

    "zope.interface" = python.mkDerivation {
      name = "zope.interface-4.5.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ac/8a/657532df378c2cd2a1fe6b12be3b4097521570769d4852ec02c24bd3594e/zope.interface-4.5.0.tar.gz"; sha256 = "57c38470d9f57e37afb460c399eb254e7193ac7fb8042bd09bdc001981a9c74c"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/zopefoundation/zope.interface";
        license = licenses.zpl21;
        description = "Interfaces for Python";
      };
    };

    "zope.sqlalchemy" = python.mkDerivation {
      name = "zope.sqlalchemy-1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/75/13/b88b597ef6027b5480f68e022206e4b3ee2310a59bbc85bd3e9eca9566b6/zope.sqlalchemy-1.0.tar.gz"; sha256 = "9316a1a8bb9e4f9f59332acf1ad2cc8b664f19a4bde5f68be7f61f3e11f80514"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."SQLAlchemy"
      self."transaction"
      self."zope.interface"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/zope.sqlalchemy";
        license = licenses.zpl21;
        description = "Minimal Zope/SQLAlchemy transaction integration";
      };
    };
  };
  localOverridesFile = ./requirements_override.nix;
  overrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
        (let src = pkgs.fetchFromGitHub { owner = "garbas"; repo = "nixpkgs-python"; rev = "5157d51f7ffc25c07d3251ef81493b996673fda3"; sha256 = "0rshv82g7jb8f3hvl5p0igz1654d6rwk5dlbl34jvv69h8140n5b"; } ; in import "${src}/overrides.nix" { inherit pkgs python; })
  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [overrides] else [] ) ++ commonOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )