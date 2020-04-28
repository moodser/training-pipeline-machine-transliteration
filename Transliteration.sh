MOSES=$HOME/mt-root/moses
SRC='en'
TGT='ur'
TRANSLIT=$HOME/tajurbat/transliteration_model_EN_UR/transmodel

# Generating Translations with seperate OOV file
$MOSES/mosesdecoder/bin/moses -f $PWD/transmodel/tuned-model/moses.ini -output-unknowns $PWD/OOV < $PWD/corpus/test.$SRC > translation-tuned-$SRC-$TGT.$TGT

#  Transliteration
$MOSES/mosesdecoder/scripts/Transliteration/post-decoding-transliteration.pl --moses-src-dir $MOSES/mosesdecoder -external-bin-dir $MOSES/mgiza/mgizapp/bin --transliteration-model-dir $TRANSLIT --oov-file $PWD/OOV --input-file $PWD/translation-tuned-$SRC-$TGT.$TGT --output-file $PWD/translited-translation-$SRC-$TGT.$TGT --input-extension $SRC --output-extension $TGT --language-model $PWD/joined-data.ur.blm.5 --decoder $MOSES/mosesdecoder/bin/moses

echo >> result.BLEU
echo >> result.BLEU
echo 'BLEU score for Tuned Translations is as follow: ' >> result.BLEU
$MOSES/mosesdecoder/scripts/generic/multi-bleu.perl corpus/test.$TGT < translation-tuned-$SRC-$TGT.$TGT >> result.BLEU 
echo >> result.BLEU
echo >> result.BLEU
echo 'BLEU score for Translations Model (Tuned) after transliteration is as follow: ' >> result.BLEU
$MOSES/mosesdecoder/scripts/generic/multi-bleu.perl corpus/test.$TGT < translited-translation-$SRC-$TGT.$TGT >> result.BLEU
