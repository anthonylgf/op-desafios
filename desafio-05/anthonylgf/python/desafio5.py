"""
Resolução do desafio 5 do site OsProgramadores, baseada na solucao
original do Roger Demetrescu, que se encontra disponivel no seguinte
link: https://github.com/rdemetrescu/OsProgramadores/blob/master/desafio-5/d05.py

Para consultar os resultados dos benchmarks dos desafios, acesse o seguinte
link: http://bcampos.com/Graphs.php
"""

import sys
import orjson
import processar_funcionarios


def processar(filename):
    """
    Este metodo ira parsear o arquivo json recebido e ira extrair as informacoes acerca dos
    funcionarios que ganham mais e menos para as respectivas areas e sobrenomes, alem de recuperar
    informacoes do total de salarios e quantidades de funcionarios.

    :param filename: nome do arquivo json contendo as informações dos funcionarios e areas
    :return: descricoes das areas e os funcionarios que ganham mais e menos para cada area e
             sobrenome
    """
    with open(filename, 'rb') as file:
        doc = orjson.loads(file.read())

    funcionarios = doc['funcionarios']
    areas = doc['areas']

    areas_descr = {x['codigo']: x['nome'] for x in areas}
    fmais, fmenos = [], []
    ais = {}  # área info's
    sis = {}  # sobrenome info's

    processar_funcionarios.recuperar_info_func(funcionarios, fmais, fmenos, ais, sis)

    return areas_descr,fmais, fmenos, ais, sis


def gerar_saida(areas_descr, fmais, fmenos,
                ais, sis):
    """
    Este metodo, a partir das informacoes recuperadas do metodo anterior, ira processar a saida
    do programa, separada por cada questao do desafio.
    """

    output = processar_funcionarios.recuperar_saida_info(areas_descr, fmais, fmenos,
                                                         ais, sis)

    print("\n".join(output))


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print(f'Rode o comando como: python {sys.argv[0]} caminho-arquivo.json')
        sys.exit(1)

    gerar_saida(*processar(sys.argv[1]))
