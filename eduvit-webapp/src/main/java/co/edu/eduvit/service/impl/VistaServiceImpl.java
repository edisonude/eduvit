package co.edu.eduvit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import co.edu.eduvit.dao.VistaDAO;
import co.edu.eduvit.entities.Vista;
import co.edu.eduvit.service.VistaService;

@Service("vistaService")
@Transactional
public class VistaServiceImpl implements VistaService {
	
	@Autowired
	private VistaDAO vistaDAO;

	public void setVistaDAO(VistaDAO vistaDAO) {
		this.vistaDAO = vistaDAO;
	}
	
	@Transactional
	public void insert(Vista vista) {
		this.vistaDAO.insert(vista);
	}

	@Transactional
	public void update(Vista vista) {
		this.vistaDAO.update(vista);
	}

	@Transactional
	public List<Vista> listAll() {
		return this.vistaDAO.listAll();
	}

	@Transactional
	public Vista findById(Integer id) {
		return this.vistaDAO.findById(id);
	}

	@Transactional
	public void delete(Integer id) {
		this.vistaDAO.delete(id);
		
	}

	
	
	
}
