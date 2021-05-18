def recuperar_info_func(funcionarios, fmais, fmenos, ais, sis):
    gmaior = -1.0
    gmenor = -1.0
    gsoma = 0
    gqtde = 0
    
    for func in funcionarios:
        sob = func['sobrenome']
        sal = func['salario']

        if sal > gmaior:
            gmaior = sal
            fmais.clear()
            fmais.append(func)
        elif sal == gmaior:
            fmais.append(func)
        
        if gmenor < 0.0 or sal < gmenor:
            gmenor = sal
            fmenos.clear()
            fmenos.append(func)
        elif sal == gmenor:
            fmenos.append(func)

        gsoma += sal
        gqtde += 1

        area = func['area']
        try:
            ai = ais[area]
            if sal > ai[0]:
                ai[0] = sal
                ai[4].clear()
                ai[4].append(func)
            elif sal == ai[0]:
                ai[4].append(func)

            if sal < ai[1]:
                ai[1] = sal
                ai[5].clear()
                ai[5].append(func)
            elif sal == ai[1]:
                ai[5].append(func)

            ai[2] += sal
            ai[3] += 1
        except KeyError:
            # maior, menor, soma, qtde, funcs que ganham mais, funcs que ganham menos
            ais[area] = [sal, sal, sal, 1, [func], [func]]

        try:
            si = sis[sob]
            _sal = si[0]
            si[1] += 1
            if sal > _sal:
                si[0] = sal
                si[2].clear()
                si[2].append(func)
            elif sal == _sal:
                si[2].append(func)
        except KeyError:
            # maior, qtde, funcs que ganham mais
            sis[sob] = [sal, 1, [func]]

    print(f'global_avg|{(gsoma / gqtde):.2f}')

def recuperar_saida_info(areas_descr, fmais, fmenos,
                         ais, sis):
    output = []
    out = output.append

    # QUESTÃO 1
    sal_max = fmais[0]["salario"]
    for func in fmais:
        out(f'global_max|{func["nome"]} {func["sobrenome"]}|{sal_max:.2f}')

    sal_min = fmenos[0]["salario"]
    for func in fmenos:
        out(f'global_min|{func["nome"]} {func["sobrenome"]}|{sal_min:.2f}')

    for area, (_, _, asoma, aqtde, afuncsmais, afuncsmenos) in ais.items():
        area_descr = areas_descr[area]

        sal_max = afuncsmais[0]["salario"]
        for func in afuncsmais:
            out(f'area_max|{area_descr}|{func["nome"]} {func["sobrenome"]}|{sal_max:.2f}')
        
        sal_menos = afuncsmenos[0]["salario"]
        for func in afuncsmenos:
            out(f'area_min|{area_descr}|{func["nome"]} {func["sobrenome"]}|{sal_menos:.2f}')

        out(f'area_avg|{area_descr}|{(asoma / aqtde):.2f}')

    # QUESTÃO 3
    max_area_qtde = max(a[3] for a in ais.values())
    min_area_qtde = min(a[3] for a in ais.values())

    for area, info in ais.items():
        if info[3] == max_area_qtde:
            out(f'most_employees|{areas_descr[area]}|{max_area_qtde}')
        if info[3] == min_area_qtde:
            out(f'least_employees|{areas_descr[area]}|{min_area_qtde}')

    # QUESTÃO 4
    for info in sis.values():
        if info[1] > 1:
            continue

        sob = info[2][0]['sobrenome']
        salario = info[2][0]['salario']
        for func in info[2]:
            out(f'last_name_max|{sob}|{func["nome"]} {sob}|{salario:.2f}')
    
    return output