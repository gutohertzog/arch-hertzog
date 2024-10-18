#!/bin/bash

function mostra_opcoes() {
    clear
    printf " Escolha um dos temas de cursor abaixo:\n"

    printf "\n Sólidos\n"
    printf "\t 1. roxo\n"
    printf "\t 2. azul\n"
    printf "\t 3. verde\n"
    printf "\t 4. cinza\n"
    printf "\t 5. preto\n"
    printf "\t 6. vermelho\n"
    printf "\t 7. rosa\n"
    printf "\t 8. branco\n"

    printf "\n Brilhantes\n"
    printf "\t 9. violeta\n"
    printf "\t10. roxo\n"
    printf "\t11. azul\n"
    printf "\t12. verde\n"
    printf "\t13. laranja\n"
    printf "\t14. lima\n"
    printf "\t15. vermelho\n"
    printf "\t16. rosa\n"
    printf "\t17. rosa fraco\n"
    printf "\t18. preto\n"
    printf "\t19. branco\n"

    printf "\t 0. padrão\n\n"

    read -p " >> " opcao
}

function ativa_cursor() {
    local cursor

    case $1 in
        0) cursor="Adwaita" ;;
        1) cursor="oreo_purple_cursors" ;;
        2) cursor="oreo_blue_cursors" ;;
        3) cursor="oreo_green_cursors" ;;
        4) cursor="oreo_grey_cursors" ;;
        5) cursor="oreo_black_cursors" ;;
        6) cursor="oreo_red_cursors" ;;
        7) cursor="oreo_pink_cursors" ;;
        8) cursor="oreo_white_cursors" ;;
        9) cursor="oreo_spark_violet_cursors" ;;
        10) cursor="oreo_spark_purple_cursors" ;;
        11) cursor="oreo_spark_blue_cursors" ;;
        12) cursor="oreo_spark_green_cursors" ;;
        13) cursor="oreo_spark_orange_cursors" ;;
        14) cursor="oreo_spark_lime_cursors" ;;
        15) cursor="oreo_spark_red_cursors" ;;
        16) cursor="oreo_spark_pink_cursors" ;;
        17) cursor="oreo_spark_light_pink_cursors" ;;
        18) cursor="oreo_spark_dark_cursors" ;;
        19) cursor="oreo_spark_lite_cursors" ;;
        *) printf "Opção inválida! Saindo..." ; exit 1 ;;
    esac

    printf "Ativando Cursor\n"
    echo "[Icon Theme]" > ~/.icons/default/index.theme
    echo "Inherits=$cursor" >> ~/.icons/default/index.theme
    printf "Novo Cursor Ativado\n"
    printf "Faça logout e login para carregar corretamente.\n\n"
}

# inicializa o script
if [ $(whoami) != "root" ]; then
    rota=$(pwd)
    # mostra_opcoes
    # ativa_cursor "$opcao"
    for f in $HOME/arch-hyprland/dotfiles/.icons/*.tar.gz; do tar xfv "$f" -C $HOME/.teste/; done
else
    clear
    printf "\n\nErro, o script não deve ser executado como root.\n\n"
    exit 0
fi
