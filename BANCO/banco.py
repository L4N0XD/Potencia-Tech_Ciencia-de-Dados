import os 

Saldo = 0
limite_saque = 3
valor_limite = 500
repeat = True
movimentacoes = []  
usuarios = {}
contas = {}

def deposito():
    os.system('cls')
    valor = float(input("Valor do Depósito: "))
    global Saldo
    if valor > 0:
        Saldo = Saldo + valor
        movimentacoes.append(f"Depósito: R${valor}")
        print(f"Saldo Atual: R${Saldo}")
    else:
        print("Operação falhou! O valor informado é inválido.")

def saque():
    os.system('cls')
    global limite_saque
    if limite_saque > 0:
        valor = float(input("Valor do Saque: "))
        if valor <= valor_limite:
            global Saldo
            if valor <= Saldo:
                Saldo = Saldo - valor
                movimentacoes.append(f"Saque: R${valor}")
                limite_saque = limite_saque - 1
                print(f"Valor sacado: R${valor}")
                print(f"Saldo Atual: R${Saldo}")
            else:
                print(f"Não autorizado! Seu saldo atual é: {Saldo}")
        else:
            print("Valor de saque maior que o limite de R$500,00")
    else:
        print("Limite de saques excedido")

def extrato():
    os.system('cls')
    print("=========== Extrato ============\n")
    if len(movimentacoes) > 0:
        for movimentacao in movimentacoes:
            print(movimentacao)
    else:
        print("Ainda não houve movimentação\n")

    print("==================================")

def criar_usuario():
    cpf = ""
    nome = str(input("Nome Completo: "))
    data_nascimento = str(input("Data de Nascimento: "))
    cpf_init = str(input("CPF (apenas números): "))
    for caractere in cpf_init:
        if caractere.isdigit():
            cpf += caractere
    endereco = str(input("Endereço (rua, nº - bairro - cidade/UF): "))
    try:
        usuarios[cpf]
        print("CPF já cadastrado!")
    except KeyError:
        usuarios[cpf] = {
        'nome': nome,
        'data_nascimento': data_nascimento,
        'endereco': endereco
        }
        print(usuarios)
    criar_mais = int(input("Deseja repetir a operação? (1) Sim (2) Não: "))
    if criar_mais == 1:
        criar_usuario()
    elif criar_mais == 2:
        pass
    else:
        print("Operação inválida, por favor selecione novamente a operação desejada.")

def criar_conta_Corrente():
    global contas
    cpf_cliente = str(input("Digite o CPF do usuário: "))
    try:
        usuarios[cpf_cliente]
        agencia = "0001"
        numero_conta = len(contas) + 1
        contas[numero_conta] = {
            'agencia': agencia,
            'numero_conta': numero_conta,
            'cpf_cliente': cpf_cliente
        }
        print(f"Conta corrente criada com sucesso! Agência: {agencia} | Número da Conta: {numero_conta} | CPF do Cliente: {cpf_cliente}")
    except KeyError:
        print("CPF não cadastrado!")

while repeat == True:
    usuario = int(input("Qual o tipo de usuário? (1) Bancário   (2) Cliente:  "))
    if usuario == 1:
        operacao_bancario = int(input("Qual operação deseja realizar? (1) Criar Usuário   (2) Criar Conta Corrente:  "))
        if operacao_bancario == 1:
            criar_usuario()
        elif operacao_bancario == 2:
            criar_conta_Corrente()
    elif usuario == 2:
        cpf_cliente = str(input("Digite o CPF: "))
        try:
            usuarios[cpf_cliente]
            print(f"Olá, {usuarios[cpf_cliente]['nome']}!")
            operacao_cliente = int(input("Qual operação deseja realizar? (1) Saque   (2) Depósito   (3) Extrato:  "))
            if operacao_cliente == 1:
                print("Operação escolhida: Saque")
                saque()
            elif operacao_cliente == 2:
                print("Operação escolhida: Depósito")
                deposito()
            elif operacao_cliente == 3:
                print("Operação escolhida: Extrato")
                extrato()
            else:
                print("Operação inválida, por favor selecione novamente a operação desejada.")    
            nova_operacao_cliente = int(input("Deseja realizar outra operação? (1) Sim   (2) Não:  "))
            if nova_operacao_cliente == 2:
                print("Obrigado por escolher o banco L4N0XD!")
                repeat = False
        except KeyError:
            print("CPF não cadastrado!")
            break
