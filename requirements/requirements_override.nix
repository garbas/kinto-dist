{ pkgs, python }:

self: super: {

  "botocore" = python.overrideDerivation super."botocore" (old: {
    patchPhase = ''
      sed -i -e "s|python-dateutil>=2.1,<3.0.0|python-dateutil|" setup.py
    '';
  });

  "ldappool" = python.overrideDerivation super."ldappool" (old: {
    buildInputs = old.buildInputs ++ [ self.pbr ];
  });

  "dockerflow" = python.overrideDerivation super."dockerflow" (old: {
    patchPhase = ''
      sed -i -e "s|setup_requires=\['setuptools_scm'\],||" setup.py
    '';
  });

  "kinto" = python.overrideDerivation super."kinto" (old: {
    patchPhase = ''
      sed -i -e "s|'pytest-runner'||" setup.py
    '';
  });

}
