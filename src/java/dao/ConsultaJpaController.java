/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dao.exceptions.NonexistentEntityException;
import dao.exceptions.RollbackFailureException;
import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.UserTransaction;
import modelo.Consulta;
import modelo.Paciente;

/**
 *
 * @author Amanda
 */
public class ConsultaJpaController implements Serializable {

    public ConsultaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("P2PU");
    }
    private EntityTransaction ent = null;
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Consulta consulta) throws RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            ent = em.getTransaction();
            ent.begin();
            Paciente cpf = consulta.getCpf();
            if (cpf != null) {
                cpf = em.getReference(cpf.getClass(), cpf.getCpf());
                consulta.setCpf(cpf);
            }
            em.persist(consulta);
            ent.commit();
        } catch (Exception ex) {
            try {
                ent.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Consulta consulta) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            ent = em.getTransaction();
            ent.begin();
            Consulta persistentConsulta = em.find(Consulta.class, consulta.getIdConsulta());
            Paciente cpfOld = persistentConsulta.getCpf();
            Paciente cpfNew = consulta.getCpf();
            if (cpfNew != null) {
                cpfNew = em.getReference(cpfNew.getClass(), cpfNew.getCpf());
                consulta.setCpf(cpfNew);
            }
            consulta = em.merge(consulta);
            if (cpfOld != null && !cpfOld.equals(cpfNew)) {
                cpfOld = em.merge(cpfOld);
            }
            if (cpfNew != null && !cpfNew.equals(cpfOld)) {
                cpfNew = em.merge(cpfNew);
            }
            ent.commit();
        } catch (Exception ex) {
            try {
                ent.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = consulta.getIdConsulta();
                if (findConsulta(id) == null) {
                    throw new NonexistentEntityException("The consulta with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            ent = em.getTransaction();
            ent.begin();
            Consulta consulta;
            try {
                consulta = em.getReference(Consulta.class, id);
                consulta.getIdConsulta();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The consulta with id " + id + " no longer exists.", enfe);
            }
            Paciente cpf = consulta.getCpf();
            if (cpf != null) {
                cpf = em.merge(cpf);
            }
            em.remove(consulta);
            ent.commit();
        } catch (Exception ex) {
            try {
                ent.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Consulta> findConsultaEntities() {
        return findConsultaEntities(true, -1, -1);
    }

    public List<Consulta> findConsultaEntities(int maxResults, int firstResult) {
        return findConsultaEntities(false, maxResults, firstResult);
    }

    private List<Consulta> findConsultaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Consulta.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Consulta findConsulta(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Consulta.class, id);
        } finally {
            em.close();
        }
    }

    public int getConsultaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Consulta> rt = cq.from(Consulta.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
