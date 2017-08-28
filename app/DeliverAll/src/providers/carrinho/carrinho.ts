import { Injectable } from '@angular/core';
import { Http } from '@angular/http';
import { Events } from 'ionic-angular';
import 'rxjs/add/operator/map';

import { Carrinho } from '../../models/carrinho';
import { Produto } from '../../models/produto';

import { AppPreferences } from '@ionic-native/app-preferences';

/*
  Generated class for the CarrinhoProvider provider.

  See https://angular.io/docs/ts/latest/guide/dependency-injection.html
  for more info on providers and Angular 2 DI.
*/
@Injectable()
export class CarrinhoProvider {

	carrinho: Carrinho;

  constructor(public http: Http, public events: Events, public appPrefs: AppPreferences) {
    
  }

  create(produto: Produto, qtd: number, idc: any, idr: any) {
  	this.carrinho = new Carrinho(idr, idc);
  	this.add_produto(produto, qtd);
  	this.appPrefs.store('car', 'carrinho', JSON.stringify(this.carrinho));
  	this.events.publish('carrinho:create');
  }

  add_produto(produto: Produto, qtd: number) {
  	this.appPrefs.fetch('car', 'carrinho').then((res) => {
      this.carrinho = JSON.parse(res);
      if (produto.restaurante_id != this.carrinho.restaurante_id) {
        this.events.publish('carrinho:addProdutoErrado');
      } else {
  	  	this.carrinho.produtos.push(produto);
  	  	this.carrinho.qtd.push(qtd);
  	  	this.appPrefs.store('car', 'carrinho', JSON.stringify(this.carrinho));
  	  	this.events.publish('carrinho:addProduto');
      }
    });
  }

  remove_produto(produto: Produto, carrinho: Carrinho) {
    console.log(produto);
  	for (var i = 0; i < carrinho.produtos.length; i--) {
  		if(carrinho.produtos[i].id == produto.id) {
  			carrinho.produtos.splice(i, 1);
  			carrinho.qtd.splice(i, 1);
        break;
  		}
  	}
  	this.appPrefs.store('car', 'carrinho', JSON.stringify(carrinho));
  	this.events.publish('carrinho:removeProduto');
  }

  getCarrinho(): any {
  	this.appPrefs.fetch('car', 'carrinho').then((res) => {
      let c: Carrinho = JSON.parse(res);
      this.carrinho = new Carrinho(c.restaurante_id, c.cliente_id);
      this.carrinho.produtos = c.produtos;
      this.carrinho.qtd = c.qtd;	
    });
	  return this.carrinho;
  }

  calc_total(carrinho: Carrinho): any {
  	let total = 0;
  	for (var i = 0; i < carrinho.produtos.length; i++) {
  		total += carrinho.produtos[i].preco * carrinho.qtd[i]
  	}
  	carrinho.total = total;
  	this.appPrefs.store('car', 'carrinho', JSON.stringify(carrinho));
  }

}