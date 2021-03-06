#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --prefix=dir      directory in which to install
  --include-subdir  include the Tutorial-1.0.1-Linux subdirectory
  --exclude-subdir  exclude the Tutorial-1.0.1-Linux subdirectory
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Tutorial Installer Version: 1.0.1, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage 
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version 
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
This is the open source License.txt file introduced in
CMake/Tests/Tutorial/Step6...

____cpack__here_doc____
    echo
    echo "Do you accept the license? [yN]: "
    read line leftover
    case ${line} in
      y* | Y*)
        cpack_license_accepted=TRUE;;
      *)
        echo "License not accepted. Exiting ..."
        exit 1;;
    esac
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Tutorial will be installed in:"
    echo "  \"${toplevel}/Tutorial-1.0.1-Linux\""
    echo "Do you want to include the subdirectory Tutorial-1.0.1-Linux?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Tutorial-1.0.1-Linux"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

tail $use_new_tail_syntax +144 "$0" | gunzip | (cd "${toplevel}" && tar xf -) || cpack_echo_exit "Problem unpacking the Tutorial-1.0.1-Linux"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;

� 8��Z �;pT�u���V��`)���l�~�5�	!��D�Ď;}z�}�6���w��"b��c&��ĸ&�c)��Ǔz�C;��D�t���tp�t��m���6R�up��=���v�{agd�$֕��{�9����{�;�9�|���ZR}��O3A�WW�WW�V���D��W�'b��0��&Ǡ)���t7ó~d�?���u��ZߞD$���H�#/������u}u�1�U���0�5�#�oi��p����'wȱ@�]^�|��}����U ll{0��i�rwX!�����"$�f<����]�;.�;k��Ǜ����i�@*����COrj����$+(bo���SSڧ�]�����ى���s���9h8:M|���y�g��K΋��H�����K��t�BB��e�\Y.!�ò������sđ�#�Ѥ�����Ot>���s�ܾ�T>94}+!/�-�z��FRHo?R:����O��C�e�n.w�p��F�����sH�|LOso|�'�������$��{$u-�~e�G�����o"��-M�Z\cs���ȉ�3��&�`]�I���N���_��7^?�w�zu���}g��_���?�g�6|�D�_L{�N�}������^{�/��ix��ofd����5����hBEzE\+��#n�5U�V k���ᱱ�GM�[����r<��#b�����߹%����m	���T��S�W�#��(+rw��r�ә'��Վba���^"l6�ʄ[��	��y;����Ln�?3� ��3�c���z6KG|��������N>ׂϵ�,p�v��,/�UPR��Nh�jhϧ9z7D������@ʃ�\&�!=�X(����T�$}�D�P$(�Q)�#�y�ek`�@{l�iô����������`�'~�_��!�b4�3r1%�є�x��&Ow<�*;�=�3�(
O@��W"P+�j��e�=��	�UdM����'�;�9�ϸ1�w�q7BKK!��50��!-d��v3��U8,�y�����݌eW���mݭ��k7O�g#�uiеP��\l��,tM��D	�o.��V��,ʀ�e
,�O�;�36b
���$��y����a�.(,"��h�ܬ��0	@��VY�����t7��u&45�������U���8������:߲��Q�vec�ՄS �Qu}����J��Y��}G�`7�=���.�t�ѣ�G*`�ax\�xju�\� ��p���Bw�,�9�K���h��(xV0NE��4�l���Ș:�6F� �n�ws�ϤPg�>`}ܥ���/�F�Ѡ򆃕�P$1P)���z<q�SMHv�#|t�v�=_�����_�:W<V�|�Gs�h��o��y`��O7�?�0,���}�݊���G��~�ᣈ<��z&o#KK�~�]�N���?}����
uǙc�=���;w�y����:6�j�/����}������?���#�M�q׻�q��?}���痊�����~m���C}��t����O�~��ϖ����e��/��a�vW[�n|��Bv�u���Hgr2��+"�0�'
���E�6@��E�H��; �`���oZ�o�����:�Jr�Ҿ[3�
��\B�Y��[�%����?��a�t?_��B��4�"ⅴ�~'_~�,�}�ɣ����Բ��-���@7��W#��$����7הXSX��A�Z;ۥ�cŝ�Ma5�0�qb@N?��@@�#俑2DJ.w�1�PeM�ɨ���T���r(B$EW��PE�D\	���3�~F>����L�%dAA��<��'�P$d�{��S����=����uW�T�&n��/�6KJ�<$�3�8�?�O���Qr�O��;K���8*Ifx�|���}1��BH��S8\�1�S8��0u��W��&B��:?㘬L9&GR+&OO�]�aj(��tz���ɩ�w�SF~��G�|����X����/��I��Ie�=1�rLT�
�H���9��/B�}�g��b(/+��;=i��_8٧oI{�_��|%�~�ʀ�x_Ӥ,y�ŭ[�z^X��&��i�r��ˑ��8ٸj4��[���{,���z'�zn����3��=t��������x���H3��@��S�����t� �Tow���� 7��}Y�7D��>UB\�2�+U��ߓ�ǘ'�ʈ�D��rO�P�Y��Yh�I���D��=���v���&��G�t<M�\��5kx[�ۑ�yB`-?�U:k�1ݫQn�j|r_��<���5<8~g`._�8�g�����]�~�����0��[*� ���ޮ��ރ#)g��ɜ���L
C�I��h2d�ǒ�?�GF���G��'/���s�&sA&�K9��M:��f�9�C�<��+�xH������A�c�˽�vP�D�ò�>E�?��c�SU�e�S��(���K�#���q��/�.}|ҫ�h�rX��7����D.��C,��u!� �-�v�h��͇��h?]����w-���m��p��-���;LA������-�.���Y���wh�� ���
�jVm8�d]K��K9IC�u/C:��{�N+�~�(ȱ����y��ܑ�F0��w�롓�>�}4�q��T�>�������;�sNa�0���<�20��nu0��������.ھL���HO���n��30�G���T�G��W�iM�~�+L��+��u
S~������n���\Bۛ�7>�3�	.���e/���)���@��^����l��^��\����"��s���`�W���#}0C���y+L~��B���B�d�_��Gz���Cc�F�v[�w����q�B,�<^[�������	Yب�"��
Y�a�y�A��	O�B�L�?��Y��?iiߕ�5D�� 0�Ofڿ�|�[P�z:í�?c�?�g��3�n.���3��q���y,����<�Y^9'�y�<�W^`���<��r�u}!}M��j�wB�/����x�%�y=�W������@V+x���f�����������l�~�ޟ�7�Po�����
��o��������~��lf?b����f7��Y�宀�tm������t}6���6�_2��!>n3����������i�����CK{_��I,��~�5���k7�%w�����B�?f7�]�7�����@�+���ǽ7�@����[��x��B�@L�{Tv��B�, ���C�|D�,��iq-���	I���Cjk=�)I$�@��~)���8:U�7�v�a)����$'H lᰢ)A��W��va*��(ɱ�|TR"Z�(����L���*��.M��E�/�;}%�S���������,5�߭�I�/F>W�>9D����7��6Aig{S��$2h.`�Ֆ��ۤ{�j�:w�5K7��Rg�n]�Y�Аu��~ޅ|ً�~q�24/=�&��������C�Tc1����|���,��ÿ�O>�^��T�E�C��]����� X��D(�����>�	� ?�j1�y���L���.��f�a��7zoz��=�P���5颢5���1�1r( P͏A2O=~ϧhO�ɎG*�%&���jm"�n���%=�`���sth��ˎ�����fC�msqך�E]����ͣ�I�����k&��L��v;��k�ǟC4lW���@�vN��E|aq�ѡ�t)���p2�я/�z�Ц�������#�n���'���n=Gw�d_��77�\������A���a�*G���	��3�}3^ڜ��P�8Q���r�#���:�p++�����Y^f��%ٗ6�^���"�8�u�W�ӽD�n�b�=��t����i�C]�����d_*��9� �i6v�����$s�o��x^���:������m�u�
���茹�ɾ���:��<1�@B����E���Y4�~/�.����lC&7~Y4��4W��"�t��@�_`�.�?���������_[_�����"�o�lR#=�^O�Rʸ��?|0���u����z_�����"x��֧�}�1%(�Q�G@"�bb\���4.��1�X"��
(�J�@:��q���~��������@���s�Yj����soA�$�*q�9Ѱ���~1SQ��
��b��;���;�M�0�6n����wx�����҂���0����%��7���j?�����j��oMmU����(BPM��.R�F�n���ݲ��rX����L @  