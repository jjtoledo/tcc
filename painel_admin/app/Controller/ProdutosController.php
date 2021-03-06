<?php
App::uses('AppController', 'Controller');
/**
 * Produtos Controller
 *
 * @property Produto $Produto
 * @property PaginatorComponent $Paginator
 * @property FlashComponent $Flash
 * @property SessionComponent $Session
 */
class ProdutosController extends AppController {

/**
 * Components
 *
 * @var array
 */
	public $components = array('Paginator', 'Flash', 'Session');

	public function afterFilter() {
		if ($this->params['controller'] == 'produtos' and empty($this->Session->check('Gerente'))) {
			$this->Session->setFlash(__('Erro de permissão!'), 'default',
                array('class' => 'text-center alert alert-danger'));
            $this->redirect('../'.$this->Session->read('redirectUrl'));	
		}
    }

/**
 * index method
 *
 * @return void
 */
	public function index() {
		$gerente = $this->Session->read('Gerente');
		$options = array('conditions' => array('Produto.restaurante_id' => $gerente['0']['Restaurante']['0']['id']));
		$this->set('produtos', $this->Produto->find('all', $options, $this->Paginator->paginate()));

		$tipo = array(
            'Hamburguer',
            'Pizzas',
            'Massas',
            'Salgados',
            'Porções',
            'Bebidas',
            'Sobremesas',
            'Doces',
            'Combos'
        );
        $this->set(compact('tipo'));
	}

/**
 * view method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function view($id = null) {
		if (!$this->Produto->exists($id)) {
			throw new NotFoundException(__('Invalid produto'));
		}
		$options = array('conditions' => array('Produto.' . $this->Produto->primaryKey => $id));
		$this->set('produto', $this->Produto->find('first', $options));

		$tipo = array(
            'Hamburguer',
            'Pizzas',
            'Massas',
            'Salgados',
            'Porções',
            'Bebidas',
            'Sobremesas',
            'Doces',
            'Combos'
        );
        $this->set(compact('tipo'));
	}

/**
 * add method
 *
 * @return void
 */
	public function add() {

		$tipo = array(
            'Hamburguer',
            'Pizzas',
            'Massas',
            'Salgados',
            'Porções',
            'Bebidas',
            'Sobremesas',
            'Doces',
            'Combos'
        );
        $this->set(compact('tipo'));

		if ($this->request->is('post')) {
			$this->Produto->create();
			if ($this->Produto->save($this->request->data)) {
				$this->Session->setFlash(__('The produto has been saved.'), 'default', array('class' => 'alert alert-success'));
				return $this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The produto could not be saved. Please, try again.'), 'default', array('class' => 'alert alert-danger'));
			}
		}
		$gerente = $this->Session->read('Gerente');
		$options = array('fields' => 'Restaurante.nome', 'conditions' => array('Restaurante.id' => $gerente['0']['Restaurante']['0']['id']));
		$restaurantes = $this->Produto->Restaurante->find('list', $options);
		$this->set(compact('restaurantes'));
	}

/**
 * edit method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function edit($id = null) {

		$tipo = array(
            'Hamburguer',
            'Pizzas',
            'Massas',
            'Salgados',
            'Porções',
            'Bebidas',
            'Sobremesas',
            'Doces',
            'Combos'
        );
        $this->set(compact('tipo'));
        
		if (!$this->Produto->exists($id)) {
			throw new NotFoundException(__('Invalid produto'));
		}
		if ($this->request->is(array('post', 'put'))) {
			if ($this->Produto->save($this->request->data)) {
				$this->Session->setFlash(__('The produto has been saved.'), 'default', array('class' => 'alert alert-success'));
				return $this->redirect(array('action' => 'index'));
			} else {
				$this->Session->setFlash(__('The produto could not be saved. Please, try again.'), 'default', array('class' => 'alert alert-danger'));
			}
		} else {
			$options = array('conditions' => array('Produto.' . $this->Produto->primaryKey => $id));
			$this->request->data = $this->Produto->find('first', $options);
		}
		$gerente = $this->Session->read('Gerente');
		$options = array('fields' => 'Restaurante.nome', 'conditions' => array('Restaurante.id' => $gerente['0']['Restaurante']['0']['id']));
		$restaurantes = $this->Produto->Restaurante->find('list', $options);
		$this->set(compact('restaurantes'));
	}

/**
 * delete method
 *
 * @throws NotFoundException
 * @param string $id
 * @return void
 */
	public function delete($id = null) {
		$this->Produto->id = $id;
		if (!$this->Produto->exists()) {
			throw new NotFoundException(__('Invalid produto'));
		}
		$this->request->onlyAllow('post', 'delete');
		if ($this->Produto->delete()) {
			$this->Session->setFlash(__('The produto has been deleted.'), 'default', array('class' => 'alert alert-success'));
		} else {
			$this->Session->setFlash(__('The produto could not be deleted. Please, try again.'), 'default', array('class' => 'alert alert-danger'));
		}
		return $this->redirect(array('action' => 'index'));
	}
}
