export class Pedido {
  id: number;
  total: number;
  status: number;
  status_nome: string;
  data: Date;
  troco: number;
  cliente_id: number;
  endereco_id: number;
  restaurante_id: number;
  public restaurante: string;
  pagamento_id: number;
  public pedido_produto: any[];

  constructor(id: number, total: number, status: number, data: Date, troco: number, cliente_id: number, endereco_id: number, restaurante_id: number, pagamento_id: number) {
  	this.id = id;
    this.total = total;
    this.data = data;
    this.status = status;
    this.status_nome = '';
    this.troco = troco;
    this.cliente_id = cliente_id;
    this.endereco_id = endereco_id;
    this.restaurante_id = restaurante_id;
    this.pagamento_id = pagamento_id;
    this.restaurante = '';
    this.pedido_produto = null;
  }
}