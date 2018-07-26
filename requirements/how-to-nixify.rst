1. Clone kinto dist repository and create a frozen set

.. code-block: console

    % git clone https://github.com/mozilla-services/kinto-dist
    % cd kinto-dist/requirements
    % nix-shell -p python35Packages.virtualenv -p postgresql libffi libxml2 libxslt openldap cyrus_sasl openssl ncurses
    (nix-shell) % export SOURCE_DATE_EPOCH=315532800
    (nix-shell) % virtualenv env
    (nix-shell) % ./env/bin/pip install -r default.txt -r prod.txt -c constraints.txt
    (nix-shell) % ./env/bin/pip freeze > frozen.txt
    (nix-shell) % exit


2. Generate

.. code-block: console

    % pypi2nix -r frozen.txt -e pbr -V 3.5 -E "postgresql libffi libxml2 libxslt openldap cyrus_sasl openssl ncurses" -v --default-overrides


3. Build

.. code-block: console

   % nix-build requirements.nix -A interpreter
   % ls result/bin
   asadmin               fetch_file       kill_instance                newrelic-admin  pyami_sendmail  rst2latex.py           sdbadmin
   blockpages-generator  fxa-client       kinto                        pbr             python          rst2man.py             taskadmin
   bundle_image          glacier          kinto2xml                    pcreate         python3         rst2odt_prepstyles.py  unidecode
   cfadmin               hupper           kinto-elasticsearch-reindex  pdistreport     python3.5m      rst2odt.py             uwsgi
   chardetect            instance_events  kinto-fxa                    prequest        qp              rst2pseudoxml.py       virtualenv
   cq                    jp.py            kinto-send-email             proutes         raven           rst2s5.py              waitress-serve
   cwutil                jsondiff         launch_instance              pserve          route53         rst2xetex.py
   dynamodb_dump         jsonpatch        list_instances               pshell          rst2html4.py    rst2xml.py
   dynamodb_load         jsonpointer      lss3                         ptweens         rst2html5.py    rstpep2html.py
   elbadmin              jsonschema       mturk                        pviews          rst2html.py     s3put
