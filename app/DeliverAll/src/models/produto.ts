export class Produto {
  id: number;
  nome: string;
  tipo: string;
  descricao: string;
  preco: number;
  foto: string;
  qtd_max_complemento: number;
  restaurante_id: number;

  constructor(id: number, nome: string, tipo: string, descricao: string, preco: number, foto: string, qtd_max_complemento: number, restaurante_id: number) {
    this.id = id;
    this.nome = nome;
    this.tipo = tipo;
    this.descricao = descricao;
    this.foto = foto;
    this.preco = preco;
    this.qtd_max_complemento = qtd_max_complemento;
    this.restaurante_id = restaurante_id;
  }
}