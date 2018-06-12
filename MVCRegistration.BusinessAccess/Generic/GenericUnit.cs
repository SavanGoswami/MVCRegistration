using MVCRegistration.DataAccess;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Validation;
using System.Linq;
using System.Linq.Expressions;

namespace MVCRegistration.BusinessAccess.Generic
{
    public class GenericUnit<TEntity> : ClsDispose where TEntity : class
    {
        #region Properties
        internal HotelDBEntities context;
        internal DbSet<TEntity> dbSet;
        #endregion

        #region Cstrt
        public GenericUnit(HotelDBEntities Context)
        {
            context = Context;
            dbSet = context.Set<TEntity>();
        }
        #endregion

        //For Crud operation general methods 
        #region General Methods 
        public virtual void Insert(TEntity Entity)
        {
            dbSet.Add(Entity);
            context.SaveChanges();
        }

        public virtual void InsertAll(List<TEntity> lstEntity)
        {
            dbSet.AddRange(lstEntity);
            context.SaveChanges();
        }

        public virtual void Update(TEntity entityToUpdate)
        {
            try
            {

                dbSet.Attach(entityToUpdate);
                context.Entry(entityToUpdate).State = EntityState.Modified;
                context.SaveChanges();
            }
            catch (DbEntityValidationException dbEx)
            {
                //Add error log here
            }
        }

        public virtual void UpdateAll(List<TEntity> lstEntity)
        {
            try
            {
                lstEntity.ForEach(x =>
                {
                    dbSet.Attach(x);
                    context.Entry(x).State = EntityState.Modified;
                });
                context.SaveChanges();
            }
            catch (DbEntityValidationException dbEx)
            {
                //Add error log here
            }
        }

        public virtual void Delete(TEntity Entity)
        {
            if (context.Entry(Entity).State == EntityState.Detached)
                dbSet.Attach(Entity);
            dbSet.Remove(Entity);
            context.SaveChanges();
        }

        public virtual void Delete(int Id)
        {
            TEntity entity = dbSet.Find(Id);
            dbSet.Remove(entity);
            context.SaveChanges();
        }

        public virtual void DeleteAll(List<TEntity> lstEntity)
        {
            dbSet.RemoveRange(lstEntity);
            context.SaveChanges();
        }

        public virtual TEntity GetById(int id)
        {
            return dbSet.Find(id);
        }

        public virtual TEntity GetById(long id)
        {
            return dbSet.Find(id);
        }

        public virtual TEntity GetById(string id)
        {
            return dbSet.Find(id);
        }

        public virtual IEnumerable<TEntity> GetAll()
        {
            return dbSet.ToList();
        }

        public virtual IEnumerable<TEntity> GetEntity(Expression<Func<TEntity, bool>> filter = null, Func<IQueryable<TEntity>, IOrderedQueryable<TEntity>> orderBy = null, string includeProperties = "")
        {
            IQueryable<TEntity> query = dbSet;

            if (filter != null)
            {
                query = query.Where(filter);
            }

            foreach (var includeProperty in includeProperties.Split
                (new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries))
            {
                query = query.Include(includeProperty);
            }

            if (orderBy != null)
            {
                return orderBy(query).ToList();
            }
            else
            {
                return query.ToList();
            }
        }

        public virtual void Save()
        {
            context.SaveChanges();
        }
        #endregion
    }
}
