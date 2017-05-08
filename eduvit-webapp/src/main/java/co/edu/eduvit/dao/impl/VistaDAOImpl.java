package co.edu.eduvit.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.edu.eduvit.dao.VistaDAO;
import co.edu.eduvit.entities.Vista;

@Repository
public class VistaDAOImpl implements VistaDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(VistaDAOImpl.class);

	@Autowired
	private SessionFactory sessionFactory;
	
	public void setSessionFactory(SessionFactory sf){
		this.sessionFactory = sf;
	}

	public void insert(Vista vista) {
		Session session = this.sessionFactory.getCurrentSession();
		session.persist(vista);
		logger.info("La vista con id"+vista.getIdRecurso()+", se guardó correctamente");
	}

	public void update(Vista vista) {
		Session session = this.sessionFactory.getCurrentSession();
		session.update(vista);
		logger.info("La vista con id = "+vista.getIdRecurso()+", se actualizó correctamente");
		
	}

	@SuppressWarnings("unchecked")
	public List<Vista> listAll() {
		Session session = this.sessionFactory.getCurrentSession();
		List<Vista> personsList = session.createQuery("from Vista").list();
		return personsList;
	}

	public Vista findById(Integer id) {
		Session session = this.sessionFactory.getCurrentSession();		
		Vista vista = (Vista) session.get(Vista.class, new Integer(id));
		logger.info("La vista con id = " + vista.getIdRecurso() + " fue encontrada");
		return vista;
	}

	public void delete(Integer id) {
		Session session = this.sessionFactory.getCurrentSession();
		Vista vista = this.findById(id);
		if (vista != null){
			session.delete(vista);
		}
		logger.info("La vista con id = " + vista.getIdRecurso() + " fue eliminada");
	}

}
