{ lib, beamPackages, overrides ? (x: y: {}) }:

let
  buildRebar3 = lib.makeOverridable beamPackages.buildRebar3;
  buildMix = lib.makeOverridable beamPackages.buildMix;
  buildErlangMk = lib.makeOverridable beamPackages.buildErlangMk;

  self = packages // (overrides self packages);

  packages = with beamPackages; with self; {
    accept = buildRebar3 rec {
      name = "accept";
      version = "0.3.5";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1f0vmjjyyz8klhdb3k8zrcxpidhfy6706327nmisnbnc1ci8rc8i";
      };

      beamDeps = [];
    };

    base62 = buildMix rec {
      name = "base62";
      version = "1.2.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1fvpygkdmd7l737lv7svir8n1vhk0m094i8ygwcvx9gam2ykc4yl";
      };

      beamDeps = [ custom_base ];
    };

    bbcode_pleroma = buildMix rec {
      name = "bbcode_pleroma";
      version = "0.2.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1hyixcxhcf2j2gyavmmnvfslnl6z60dz1qa9xysfspws85s1118r";
      };

      beamDeps = [ nimble_parsec ];
    };

    bcrypt_elixir = buildMix rec {
      name = "bcrypt_elixir";
      version = "2.3.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0ybjs37fyn45x31lzhxic4kd4jmzwcwkgy4spwayykbn8rgjs622";
      };

      beamDeps = [ comeonin elixir_make ];
    };

    benchee = buildMix rec {
      name = "benchee";
      version = "1.1.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "14vdbvmkkqhcqvilq1w8zl895f4hpbv7fw2q5c0ml5h3a1a7v9bx";
      };

      beamDeps = [ deep_merge statistex ];
    };

    bunt = buildMix rec {
      name = "bunt";
      version = "0.2.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "19bp6xh052ql3ha0v3r8999cvja5d2p6cph02mxphfaj4jsbyc53";
      };

      beamDeps = [];
    };

    cachex = buildMix rec {
      name = "cachex";
      version = "3.6.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1qp2r1f4hvpybhgi547p33ci7bh2w6xn6jl9il68xg4370vlxwpb";
      };

      beamDeps = [ eternal jumper sleeplocks unsafe ];
    };

    calendar = buildMix rec {
      name = "calendar";
      version = "1.0.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0vqa1zpzsdgr6i3yx8j9b6qscvgrbvzn43p5bqm930hcja0ra3lr";
      };

      beamDeps = [ tzdata ];
    };

    castore = buildMix rec {
      name = "castore";
      version = "0.1.22";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1b1cl89fzkykimxwgm8mwb9wmxcrd8qk8hfc83pa2npb8zgpcxf1";
      };

      beamDeps = [];
    };

    certifi = buildRebar3 rec {
      name = "certifi";
      version = "2.9.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0ha6vmf5p3xlbf5w1msa89frhvfk535rnyfybz9wdmh6vdms8v96";
      };

      beamDeps = [];
    };

    combine = buildMix rec {
      name = "combine";
      version = "0.10.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "06s5y8b0snr1s5ax9v3s7rc6c8xf5vj6878d1mc7cc07j0bvq78v";
      };

      beamDeps = [];
    };

    comeonin = buildMix rec {
      name = "comeonin";
      version = "5.3.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1pw4rhhsh8mwj26dkbxz2niih9j8pc3qijlpcl8jh208rg1cjf1y";
      };

      beamDeps = [];
    };

    concurrent_limiter = buildMix rec {
      name = "concurrent_limiter";
      version = "0.1.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1sqnb987qwwy4ip7kxh9g7vv5wz61fpv3pbnxpbv9yy073r8z5jk";
      };

      beamDeps = [ telemetry ];
    };

    connection = buildMix rec {
      name = "connection";
      version = "1.1.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1746n8ba11amp1xhwzp38yfii2h051za8ndxlwdykyqqljq1wb3j";
      };

      beamDeps = [];
    };

    cors_plug = buildMix rec {
      name = "cors_plug";
      version = "2.0.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1sls8rns2k48qrga0ngysbn9aknapmn3xfn28by1gqbcir0y2jpf";
      };

      beamDeps = [ plug ];
    };

    covertool = buildRebar3 rec {
      name = "covertool";
      version = "2.0.4";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1p0c1n3nl4063xwi1sv176l1x68xqf07qwvj444a5z888fx6i5aw";
      };

      beamDeps = [];
    };

    cowboy = buildErlangMk rec {
      name = "cowboy";
      version = "2.9.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1phv0a1zbgk7imfgcm0dlacm7hbjcdygb0pqmx4s26jf9f9rywic";
      };

      beamDeps = [ cowlib ranch ];
    };

    cowboy_telemetry = buildRebar3 rec {
      name = "cowboy_telemetry";
      version = "0.4.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1pn90is3k9dq64wbijvzkqb6ldfqvwiqi7ymc8dx6ra5xv0vm63x";
      };

      beamDeps = [ cowboy telemetry ];
    };

    cowlib = buildRebar3 rec {
      name = "cowlib";
      version = "2.12.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1c4dgi8canscyjgddp22mjc69znvwy44wk3r7jrl2wvs6vv76fqn";
      };

      beamDeps = [];
    };

    credo = buildMix rec {
      name = "credo";
      version = "1.7.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1mv9lyw6hgjn6hlnzfbs0x2dchvwlmj8bg0a8l7iq38z7pvgqfb8";
      };

      beamDeps = [ bunt file_system jason ];
    };

    crontab = buildMix rec {
      name = "crontab";
      version = "1.1.8";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1gkb7ps38j789acj8dw2q7jnhhw43idyvh36fb3i52yjkhli7ra8";
      };

      beamDeps = [ ecto ];
    };

    custom_base = buildMix rec {
      name = "custom_base";
      version = "0.2.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0qx47d4w2mxa3rr6mrxdasgk7prxqwd0y9zpjhz61jayrkx1kw4d";
      };

      beamDeps = [];
    };

    db_connection = buildMix rec {
      name = "db_connection";
      version = "2.4.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "04iwywfqf8k125yfvm084l1mp0bcv82mwih7xlpb7kx61xdw29y1";
      };

      beamDeps = [ connection telemetry ];
    };

    decimal = buildMix rec {
      name = "decimal";
      version = "2.0.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0xzm8hfhn8q02rmg8cpgs68n5jz61wvqg7bxww9i1a6yanf6wril";
      };

      beamDeps = [];
    };

    deep_merge = buildMix rec {
      name = "deep_merge";
      version = "1.0.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0c2li2a3hxcc05nwvy4kpsal0315yk900kxyybld972b15gqww6f";
      };

      beamDeps = [];
    };

    earmark = buildMix rec {
      name = "earmark";
      version = "1.4.22";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1yzx2j48cxny7l8ap1jgq2qiz1kiq6q8cwiismvgshjscr2m3bqw";
      };

      beamDeps = [ earmark_parser ];
    };

    earmark_parser = buildMix rec {
      name = "earmark_parser";
      version = "1.4.31";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0nfhxyklbz0ixkl33xqkchqgdzk948dcjikym0vz0pikw1z3cz9i";
      };

      beamDeps = [];
    };

    eblurhash = buildRebar3 rec {
      name = "eblurhash";
      version = "1.2.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0k040pj8hlm8mwy0ra459hk35v9gfsvvgp596nl27q2dj00cl84c";
      };

      beamDeps = [];
    };

    ecto = buildMix rec {
      name = "ecto";
      version = "3.9.5";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0k5p40cy6zxi3wm885amf78724zvb5a8chmpljzw1kdsiifi3wyl";
      };

      beamDeps = [ decimal jason telemetry ];
    };

    ecto_enum = buildMix rec {
      name = "ecto_enum";
      version = "1.4.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1r2ffrr020fhfviqn21cv06sd3sp4bf1jra0xrgb3hl1f445rdcg";
      };

      beamDeps = [ ecto ecto_sql postgrex ];
    };

    ecto_psql_extras = buildMix rec {
      name = "ecto_psql_extras";
      version = "0.7.10";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "123h3s4zpk5q618rcxlfz4axj3rz3cmyk68gps8c05sg3vc8qpjh";
      };

      beamDeps = [ ecto_sql postgrex table_rex ];
    };

    ecto_sql = buildMix rec {
      name = "ecto_sql";
      version = "3.9.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0w1zplm8ndf10dwxffg60iwzvbz3hyyiy761x91cvnwg6nsfxd8y";
      };

      beamDeps = [ db_connection ecto postgrex telemetry ];
    };

    eimp = buildRebar3 rec {
      name = "eimp";
      version = "1.0.14";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1dl3xdfd42y389fc3sbssva163jgpy48pni2kqnvjy9027rk64ah";
      };

      beamDeps = [ p1_utils ];
    };

    elixir_make = buildMix rec {
      name = "elixir_make";
      version = "0.6.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "05ppvbhqi5m9zk1c4xnrki814sqhxrc7d1dpvfmwm2v7qm8xdjzm";
      };

      beamDeps = [];
    };

    esbuild = buildMix rec {
      name = "esbuild";
      version = "0.5.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1rgzjjb0j3m0xz8gs112dydfz7m5brlpfm2qmz7w8qyr6ars10zi";
      };

      beamDeps = [ castore ];
    };

    eternal = buildMix rec {
      name = "eternal";
      version = "1.2.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "10p7m6kv2z2c16gw36wgiwnkykss4lfkmm71llxp09ipkhmy77rc";
      };

      beamDeps = [];
    };

    ex_aws = buildMix rec {
      name = "ex_aws";
      version = "2.1.9";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "040dmj94xg3wnk9wplm0myr2q12zad4w1xz1zc0n01y90dkpfv1y";
      };

      beamDeps = [ hackney jason sweet_xml ];
    };

    ex_aws_s3 = buildMix rec {
      name = "ex_aws_s3";
      version = "2.4.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1fsngrldq2g3i2f7y5m4d85sd7hx4jiwnfcxhs14bnalfziadpc5";
      };

      beamDeps = [ ex_aws sweet_xml ];
    };

    ex_const = buildMix rec {
      name = "ex_const";
      version = "0.2.4";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0rwppain0bd36krph1as0vxlxb42psc6mlkfi67jp6fc21k39zcn";
      };

      beamDeps = [];
    };

    ex_doc = buildMix rec {
      name = "ex_doc";
      version = "0.29.4";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1xf49d0ni08a83iankdj8fb6jyxm67wjl0gdwihwnimf6ykrjric";
      };

      beamDeps = [ earmark_parser makeup_elixir makeup_erlang ];
    };

    ex_machina = buildMix rec {
      name = "ex_machina";
      version = "2.7.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1y2v4j1zg1ji8q8di0fxpc3z3n2jmbnc85d6hx68j4fykfisg6j1";
      };

      beamDeps = [ ecto ecto_sql ];
    };

    ex_syslogger = buildMix rec {
      name = "ex_syslogger";
      version = "1.5.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "16c376cvw0bcjz8a6gs3nhmg037i894gl5kgxi8jdinv6r0sp7xb";
      };

      beamDeps = [ poison syslog ];
    };

    expo = buildMix rec {
      name = "expo";
      version = "0.4.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0iyfl4vppfhmimfqaracjza9a6y8rgia03sm28y5934cg5xbmxrg";
      };

      beamDeps = [];
    };

    fast_html = buildMix rec {
      name = "fast_html";
      version = "2.0.5";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "01k51qri44535b1hwixlxk7151vph6vapswlfq918g245544ypv0";
      };

      beamDeps = [ elixir_make nimble_pool ];
    };

    fast_sanitize = buildMix rec {
      name = "fast_sanitize";
      version = "0.2.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1qjnbs63q0d95dqhh2r9sz3zpg2y4hjy23kxsqanwf6h21njibg8";
      };

      beamDeps = [ fast_html plug ];
    };

    file_system = buildMix rec {
      name = "file_system";
      version = "0.2.10";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1p0myxmnjjds8bbg69dd6fvhk8q3n7lb78zd4qvmjajnzgdmw6a1";
      };

      beamDeps = [];
    };

    finch = buildMix rec {
      name = "finch";
      version = "0.10.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0l3mvf0jnh49rj58vj1051fvsj6294wjhlh8ycpfqb07har132yx";
      };

      beamDeps = [ castore mint nimble_options nimble_pool telemetry ];
    };

    flake_id = buildMix rec {
      name = "flake_id";
      version = "0.1.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "09yq3dlqqrb7v4ysblwpz1al0q5qcmryldkwq1kx5b71zn881z1i";
      };

      beamDeps = [ base62 ecto ];
    };

    floki = buildMix rec {
      name = "floki";
      version = "0.34.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1j6ilik6pviff34rrqr8456h7pp0qlash731pv36ny811w7xbf96";
      };

      beamDeps = [];
    };

    gen_smtp = buildRebar3 rec {
      name = "gen_smtp";
      version = "0.15.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "03s40l97j6z4mx6a84cbl9w94v3dvfw4f97dqx4hi61hh2l19g99";
      };

      beamDeps = [];
    };

    gettext = buildMix rec {
      name = "gettext";
      version = "0.22.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0q0gqcgdrksjjjqvxrqa1080crhjrhn6lziqmrz2va5fffb3hbca";
      };

      beamDeps = [ expo ];
    };

    gun = buildRebar3 rec {
      name = "gun";
      version = "2.0.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0sa5s1v5zg6w574qydc8p9366mgqfbd4vi33hbawh3ckc9ycn4v6";
      };

      beamDeps = [ cowlib ];
    };

    hackney = buildRebar3 rec {
      name = "hackney";
      version = "1.18.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "13hja14kig5jnzcizpdghj68i88f0yd9wjdfjic9nzi98kzxmv54";
      };

      beamDeps = [ certifi idna metrics mimerl parse_trans ssl_verify_fun unicode_util_compat ];
    };

    hpax = buildMix rec {
      name = "hpax";
      version = "0.1.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "04wci9ifsfyd2pbcrnpgh2aq0a8fi1lpkrzb91kz3x93b8yq91rc";
      };

      beamDeps = [];
    };

    html_entities = buildMix rec {
      name = "html_entities";
      version = "0.5.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1k7xyj0q38ms3n5hbn782pa6w1vgd6biwlxr4db6319l828a6fy5";
      };

      beamDeps = [];
    };

    http_signatures = buildMix rec {
      name = "http_signatures";
      version = "0.1.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "18s2b5383xl2qjijkxag4mvwk2p5kv2fw58c9ii7pk12fc08lfyc";
      };

      beamDeps = [];
    };

    httpoison = buildMix rec {
      name = "httpoison";
      version = "1.8.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "08crb48yz7r7w00pzw9gfk862g99z2ma2x6awab0rqvjd7951crb";
      };

      beamDeps = [ hackney ];
    };

    idna = buildRebar3 rec {
      name = "idna";
      version = "6.1.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1sjcjibl34sprpf1dgdmzfww24xlyy34lpj7mhcys4j4i6vnwdwj";
      };

      beamDeps = [ unicode_util_compat ];
    };

    inet_cidr = buildMix rec {
      name = "inet_cidr";
      version = "1.0.4";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1g61i08cizr99ivy050lv8fmvnwia9zmipfvlwff8jkhi40x78k4";
      };

      beamDeps = [];
    };

    jason = buildMix rec {
      name = "jason";
      version = "1.4.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0891p2yrg3ri04p302cxfww3fi16pvvw1kh4r91zg85jhl87k8vr";
      };

      beamDeps = [ decimal ];
    };

    joken = buildMix rec {
      name = "joken";
      version = "2.6.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "19xanmavc4n5zzypxyi4qd93m8l7sjqswy2ksfmm82ydf5db15as";
      };

      beamDeps = [ jose ];
    };

    jose = buildMix rec {
      name = "jose";
      version = "1.11.5";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "115k981kfg9jmafgs16rybc5qah6p0zgvni3bdyfl0pyp8av5lyw";
      };

      beamDeps = [];
    };

    jumper = buildMix rec {
      name = "jumper";
      version = "1.0.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0cvlbfkapkvbwaijmjq3cxg5m6yv4rh69wvss9kfj862i83mk31i";
      };

      beamDeps = [];
    };

    linkify = buildMix rec {
      name = "linkify";
      version = "0.5.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0xw14ls480jzha9fx4lxd40dff4xx82w1h87dr82az6lfw9mmwry";
      };

      beamDeps = [];
    };

    majic = buildMix rec {
      name = "majic";
      version = "1.0.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "17hab8kmqc6gsiqicfgsaik0rvmakb6mbshlbxllj3b5fs7qa1br";
      };

      beamDeps = [ elixir_make mime nimble_pool plug ];
    };

    makeup = buildMix rec {
      name = "makeup";
      version = "1.0.5";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1a9cp9zp85yfybhdxapi9haa1yykzq91bw8abmk0qp1z5p05i8fg";
      };

      beamDeps = [ nimble_parsec ];
    };

    makeup_elixir = buildMix rec {
      name = "makeup_elixir";
      version = "0.14.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "04fyrd0fcyfvv4i3ngm3gbykhfrp9z6l2p1bhgg9xv7ah0d8nhzj";
      };

      beamDeps = [ makeup ];
    };

    makeup_erlang = buildMix rec {
      name = "makeup_erlang";
      version = "0.1.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1fvw0zr7vqd94vlj62xbqh0yrih1f7wwnmlj62rz0klax44hhk8p";
      };

      beamDeps = [ makeup ];
    };

    meck = buildRebar3 rec {
      name = "meck";
      version = "0.9.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "09jq0jrsd3dwzjlnwqjv6m9r2rijgiv57yja6jl41p2p2db4yd41";
      };

      beamDeps = [];
    };

    metrics = buildRebar3 rec {
      name = "metrics";
      version = "1.0.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "05lz15piphyhvvm3d1ldjyw0zsrvz50d2m5f2q3s8x2gvkfrmc39";
      };

      beamDeps = [];
    };

    mime = buildMix rec {
      name = "mime";
      version = "1.6.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "19qrpnmaf3w8bblvkv6z5g82hzd10rhc7bqxvqyi88c37xhsi89i";
      };

      beamDeps = [];
    };

    mimerl = buildRebar3 rec {
      name = "mimerl";
      version = "1.2.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "08wkw73dy449n68ssrkz57gikfzqk3vfnf264s31jn5aa1b5hy7j";
      };

      beamDeps = [];
    };

    mint = buildMix rec {
      name = "mint";
      version = "1.5.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "07jvgmggmv6bxhkmrskdjz1xvv0a1l53fby7sammcfbwdbky2qsa";
      };

      beamDeps = [ castore hpax ];
    };

    mochiweb = buildRebar3 rec {
      name = "mochiweb";
      version = "2.18.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "16j8cfn3hq0g474xc5xl8nk2v46hwvwpfwi9rkzavnsbaqg2ngmr";
      };

      beamDeps = [];
    };

    mock = buildMix rec {
      name = "mock";
      version = "0.3.7";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0p3yrx049fdw88kjidngd2lkwqkkyck5r51ng2dxj7z41539m92d";
      };

      beamDeps = [ meck ];
    };

    mogrify = buildMix rec {
      name = "mogrify";
      version = "0.9.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "17b9dy40rq3rwn7crjggjafibxz4ys4nqq81adcf486af3yi13f1";
      };

      beamDeps = [];
    };

    mox = buildMix rec {
      name = "mox";
      version = "1.0.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1wpyh6wp76lyx0q2cys23rpmci4gj1pqwnqvfk467xxanchlk1pr";
      };

      beamDeps = [];
    };

    nimble_options = buildMix rec {
      name = "nimble_options";
      version = "0.4.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0bd0pi3sij9vxhiilv25x6n3jls75g3b38rljvm1x896ycd1qw76";
      };

      beamDeps = [];
    };

    nimble_parsec = buildMix rec {
      name = "nimble_parsec";
      version = "0.6.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0liwhwfcmx6gka555sn56y93gj067sla81xwd3fd82a9m4aw7si7";
      };

      beamDeps = [];
    };

    nimble_pool = buildMix rec {
      name = "nimble_pool";
      version = "0.2.6";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0gv59waa505mz2gi956sj1aa6844c65w2dp2qh2jfgsx15am0w8w";
      };

      beamDeps = [];
    };

    oauth2 = buildMix rec {
      name = "oauth2";
      version = "2.1.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0h9bps7gq7bac5gc3q0cgpsj46qnchpqbv5hzsnd2z9hnf2pzh4a";
      };

      beamDeps = [ tesla ];
    };

    oban = buildMix rec {
      name = "oban";
      version = "2.13.6";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "11s88vsjlz0b4s3arlgrb8l92g8fs8jbw57ayaxkqyrpdyqmw71w";
      };

      beamDeps = [ ecto_sql jason postgrex telemetry ];
    };

    open_api_spex = buildMix rec {
      name = "open_api_spex";
      version = "3.16.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1yyvvyzzi6k2l55fl4wijhrzzdjns95asxcbnikgh6hjmiwdfvzg";
      };

      beamDeps = [ jason plug poison ];
    };

    parse_trans = buildRebar3 rec {
      name = "parse_trans";
      version = "3.3.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "12w8ai6b5s6b4hnvkav7hwxd846zdd74r32f84nkcmjzi1vrbk87";
      };

      beamDeps = [];
    };

    pbkdf2_elixir = buildMix rec {
      name = "pbkdf2_elixir";
      version = "1.2.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "07s862m4y74fyv9gwdhrhx04rvpfrwgqkjlyy51b9w1h8r50md6k";
      };

      beamDeps = [ comeonin ];
    };

    phoenix = buildMix rec {
      name = "phoenix";
      version = "1.6.16";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0fdca3h6k9plv1qvch6zyl6wbnfhp8jisvggjmmsjw7n6kzqjng1";
      };

      beamDeps = [ castore jason phoenix_pubsub phoenix_view plug plug_cowboy plug_crypto telemetry ];
    };

    phoenix_ecto = buildMix rec {
      name = "phoenix_ecto";
      version = "4.4.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1h9wnjmxns8y8dsr0r41ks66gscaqm7ivk4gsh5y07nkiralx1h9";
      };

      beamDeps = [ ecto phoenix_html plug ];
    };

    phoenix_html = buildMix rec {
      name = "phoenix_html";
      version = "3.3.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1lyhagjpg4lran6431csgkvf28g50mdvh4mlsxgs21j9vmp91ldy";
      };

      beamDeps = [ plug ];
    };

    phoenix_live_dashboard = buildMix rec {
      name = "phoenix_live_dashboard";
      version = "0.6.5";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0lmq1m7k465i9mzw35l7bx69n85mibwzd76976840r43sw6sakzg";
      };

      beamDeps = [ ecto ecto_psql_extras mime phoenix_live_view telemetry_metrics ];
    };

    phoenix_live_reload = buildMix rec {
      name = "phoenix_live_reload";
      version = "1.3.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1b5blinpmzdgspgk0dsy01bfjwwnhikb1gfiwnx8smazdrkrcrvn";
      };

      beamDeps = [ file_system phoenix ];
    };

    phoenix_live_view = buildMix rec {
      name = "phoenix_live_view";
      version = "0.17.14";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1lzbzbv956j0gyxzw9gh8m9rjf9hdpycv6hwzkvscag37jj6psxg";
      };

      beamDeps = [ jason phoenix phoenix_html telemetry ];
    };

    phoenix_pubsub = buildMix rec {
      name = "phoenix_pubsub";
      version = "2.1.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1nfqrmbrq45if9pgk6g6vqiply2sxc40is3bfanphn7a3rnpqdl1";
      };

      beamDeps = [];
    };

    phoenix_swoosh = buildMix rec {
      name = "phoenix_swoosh";
      version = "1.2.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1fhxh4sff7b3qz2lyryzgms9d6mrhxnmlh924awid6p8a5r133g8";
      };

      beamDeps = [ finch hackney phoenix phoenix_html phoenix_view swoosh ];
    };

    phoenix_template = buildMix rec {
      name = "phoenix_template";
      version = "1.0.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1vlkd4z2bxinczwcysydidpnh49rpxjihb5k3k4k8qr2yrwc0z8m";
      };

      beamDeps = [ phoenix_html ];
    };

    phoenix_view = buildMix rec {
      name = "phoenix_view";
      version = "2.0.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0vykabqxyk08gkfm45zy5dnlnzygwx6g9z4z2h7fxix51qiyfad9";
      };

      beamDeps = [ phoenix_html phoenix_template ];
    };

    plug = buildMix rec {
      name = "plug";
      version = "1.10.4";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1874ixvvjklg0hnxr6d990qzarvvfxhd4s35c5bfqbixwwzj67md";
      };

      beamDeps = [ mime plug_crypto telemetry ];
    };

    plug_cowboy = buildMix rec {
      name = "plug_cowboy";
      version = "2.6.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "04v6xc4v741dr2y38j66fmcc4xc037dnaxzkj2vih6j53yif2dny";
      };

      beamDeps = [ cowboy cowboy_telemetry plug ];
    };

    plug_crypto = buildMix rec {
      name = "plug_crypto";
      version = "1.2.5";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0hnqgzc3zas7j7wycgnkkdhaji5farkqccy2n4p1gqj5ccfrlm16";
      };

      beamDeps = [];
    };

    plug_static_index_html = buildMix rec {
      name = "plug_static_index_html";
      version = "1.0.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1kxm1flxw3rnsj5jj24c2p23wq1wyblbl32n4rf6046i6k7lzzbr";
      };

      beamDeps = [ plug ];
    };

    poison = buildMix rec {
      name = "poison";
      version = "3.1.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1kng8xadrs03i77irxvdk9vfncrqzncmgxc5gc8y8gkknw76dj7y";
      };

      beamDeps = [];
    };

    poolboy = buildRebar3 rec {
      name = "poolboy";
      version = "1.5.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1qq116314418jp4skxg8c6jx29fwp688a738lgaz6h2lrq29gmys";
      };

      beamDeps = [];
    };

    postgrex = buildMix rec {
      name = "postgrex";
      version = "0.16.5";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1s5jbwfzsdsyvlwgx3bqlfwilj2c468wi3qxq0c2d23fvhwxdspd";
      };

      beamDeps = [ connection db_connection decimal jason ];
    };

    pot = buildRebar3 rec {
      name = "pot";
      version = "1.0.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1q62ascgjgddq0l42nvysfwkxmbvh9qsd8m5dsfr2psgb9zi5zkq";
      };

      beamDeps = [];
    };

    prom_ex = buildMix rec {
      name = "prom_ex";
      version = "1.7.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "027dlv89wl35wy0lbl7xf7308j42c42ls3ssj8rri4lap1r8i5sc";
      };

      beamDeps = [ ecto finch jason oban phoenix phoenix_live_view plug plug_cowboy telemetry telemetry_metrics telemetry_metrics_prometheus_core telemetry_poller ];
    };

    prometheus = buildMix rec {
      name = "prometheus";
      version = "4.10.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "114ksp1s78jfmhm9dgfx4324v0zrch06ppkg4g3kiql5rrnvp69a";
      };

      beamDeps = [ quantile_estimator ];
    };

    prometheus_ecto = buildMix rec {
      name = "prometheus_ecto";
      version = "1.4.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "10pd5cmm6m62xwlfp7al8yj62zn181rjizc1v9zb64zrfygjhrld";
      };

      beamDeps = [ ecto prometheus_ex ];
    };

    prometheus_phoenix = buildMix rec {
      name = "prometheus_phoenix";
      version = "1.3.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0xccdidbzffgy2mpy18p017ijcgav2kv47b0v9ixklz9qi541lf4";
      };

      beamDeps = [ phoenix prometheus_ex ];
    };

    prometheus_plugs = buildMix rec {
      name = "prometheus_plugs";
      version = "1.1.5";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0ybazh6r52vjpf14gjcphsavl3ggk9iapc0rr9wnv4yb7i4acwq2";
      };

      beamDeps = [ accept plug prometheus_ex ];
    };

    quantile_estimator = buildRebar3 rec {
      name = "quantile_estimator";
      version = "0.2.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0im97lp44bfp8qqfdva198fnqxwg6ikd31zpwv4lba527hr8lai8";
      };

      beamDeps = [];
    };

    ranch = buildRebar3 rec {
      name = "ranch";
      version = "1.8.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1rfz5ld54pkd2w25jadyznia2vb7aw9bclck21fizargd39wzys9";
      };

      beamDeps = [];
    };

    recon = buildMix rec {
      name = "recon";
      version = "2.5.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1mwr6267lwl4p7f8jfk14s4cszxwra6zgf84hkcxz8fldzs86rkc";
      };

      beamDeps = [];
    };

    sleeplocks = buildRebar3 rec {
      name = "sleeplocks";
      version = "1.1.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "19argym7xifhsbrp21glkgs0dz1xpd00yfhsbhqdd0dpqm4d1rcz";
      };

      beamDeps = [];
    };

    ssl_verify_fun = buildRebar3 rec {
      name = "ssl_verify_fun";
      version = "1.1.6";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1026l1z1jh25z8bfrhaw0ryk5gprhrpnirq877zqhg253x3x5c5x";
      };

      beamDeps = [];
    };

    statistex = buildMix rec {
      name = "statistex";
      version = "1.0.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "09vcm2sz2llv00cm7krkx3n5r8ra1b42zx9gfjs8l0imf3p8p7gz";
      };

      beamDeps = [];
    };

    sweet_xml = buildMix rec {
      name = "sweet_xml";
      version = "0.7.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1fpmwhqgvakvdpbwmmyh31ays3hzhnm9766xqyzp9zmkl5kwh471";
      };

      beamDeps = [];
    };

    swoosh = buildMix rec {
      name = "swoosh";
      version = "1.9.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "07ipsrp34s18c9zd5kglqsdc8z7gxa9aadsrklj0zf6azzrzzpvn";
      };

      beamDeps = [ cowboy ex_aws finch gen_smtp hackney jason mime plug_cowboy telemetry ];
    };

    syslog = buildRebar3 rec {
      name = "syslog";
      version = "1.1.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1qarnqappln4xhlr700rhnhfnfvgvv9l3y1ywdxmh83y7hvl2sjc";
      };

      beamDeps = [];
    };

    table_rex = buildMix rec {
      name = "table_rex";
      version = "3.1.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "141404hwnwnpspvhs112j2la8dfnvkwr0xy14ff42w6nljmj72k7";
      };

      beamDeps = [];
    };

    telemetry = buildRebar3 rec {
      name = "telemetry";
      version = "1.0.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0yn5mr83hrx0dslsqxmfr5zf0a65hdak6926zd72i85lb7x0kg3k";
      };

      beamDeps = [];
    };

    telemetry_metrics = buildMix rec {
      name = "telemetry_metrics";
      version = "0.6.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1iilk2n75kn9i95fdp8mpxvn3rcn3ghln7p77cijqws13j3y1sbv";
      };

      beamDeps = [ telemetry ];
    };

    telemetry_metrics_prometheus_core = buildMix rec {
      name = "telemetry_metrics_prometheus_core";
      version = "1.0.2";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0c5pfm0jbri0x7p6cryif0b0h2iy0jqk4hmljz4kh3pqaq6ilda8";
      };

      beamDeps = [ telemetry telemetry_metrics ];
    };

    telemetry_poller = buildRebar3 rec {
      name = "telemetry_poller";
      version = "1.0.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0vjgxkxn9ll1gc6xd8jh4b0ldmg9l7fsfg7w63d44gvcssplx8mk";
      };

      beamDeps = [ telemetry ];
    };

    tesla = buildMix rec {
      name = "tesla";
      version = "1.4.4";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0mv48vgby1fv9b2npc0ird3y4isr10np3a3yas3v5hfyz54kll6m";
      };

      beamDeps = [ castore finch gun hackney jason mime mint poison telemetry ];
    };

    timex = buildMix rec {
      name = "timex";
      version = "3.7.7";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "19x0vz2bcj9qb2jxg0clna7f9zrsgr51817wz4hi6cgy4ngv1i0f";
      };

      beamDeps = [ combine gettext tzdata ];
    };

    trailing_format_plug = buildMix rec {
      name = "trailing_format_plug";
      version = "0.0.7";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0gv9z8m1kpfs5f5zcsh9m6vr36s88x1xc6g0k6lr7sgk2m6dwkxx";
      };

      beamDeps = [ plug ];
    };

    tzdata = buildMix rec {
      name = "tzdata";
      version = "1.0.5";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "0nia83zpk0pb4jkpvhkmmgw8i5p6kd6cf776q6aj0pcym6i9llam";
      };

      beamDeps = [ hackney ];
    };

    ueberauth = buildMix rec {
      name = "ueberauth";
      version = "0.10.5";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1qf97azn8064ymawfm58p2bqpmrigipr4fs5xp3jb8chshqizz9y";
      };

      beamDeps = [ plug ];
    };

    ueberauth_keycloak_strategy = buildMix rec {
      name = "ueberauth_keycloak_strategy";
      version = "0.4.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "06r10w0azlpypjgggar1lf7h2yazn2dpyicy97zxkjyxgf9jfc60";
      };

      beamDeps = [ oauth2 ueberauth ];
    };

    unicode_util_compat = buildRebar3 rec {
      name = "unicode_util_compat";
      version = "0.7.0";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "08952lw8cjdw8w171lv8wqbrxc4rcmb3jhkrdb7n06gngpbfdvi5";
      };

      beamDeps = [];
    };

    unsafe = buildMix rec {
      name = "unsafe";
      version = "1.0.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1rahpgz1lsd66r7ycns1ryz2qymamz1anrlps986900lsai2jxvc";
      };

      beamDeps = [];
    };

    web_push_encryption = buildMix rec {
      name = "web_push_encryption";
      version = "0.3.1";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "18p2f1gqkg209vf3nychjxy7xpxhgiwyhn4halvr7yr2fvjv50jg";
      };

      beamDeps = [ httpoison jose ];
    };

    websockex = buildMix rec {
      name = "websockex";
      version = "0.4.3";

      src = fetchHex {
        pkg = "${name}";
        version = "${version}";
        sha256 = "1r2kmi2pcmdzvgbd08ci9avy0g5p2lhx80jn736a98w55c3ygwlm";
      };

      beamDeps = [];
    };
  };
in self

