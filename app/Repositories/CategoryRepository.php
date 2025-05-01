<?php

namespace App\Repositories;

use App\Models\Category;
use App\Repositories\Contracts\CategoryRepositoryInterface;
use Illuminate\Support\Str;

class CategoryRepository implements CategoryRepositoryInterface
{
    
    protected $model;
    
    
    public function __construct(Category $category)
    {
        $this->model = $category;
    }
    
  
    public function all(array $columns = ['*'])
    {
        return $this->model->all($columns);
    }
 
    public function paginate(int $perPage = 15)
    {
        return $this->model->paginate($perPage);
    }
    public function getCategories($search = null, $sortBy = 'created_at', $sortDirection = 'desc', $perPage = 15)
{
    $query = Category::query();
    
    // Apply search if provided
    if ($search) {
        $query->where(function($q) use ($search) {
            $q->where('name', 'like', "%{$search}%")
              ->orWhere('description', 'like', "%{$search}%");
        });
    }
    
    // Apply sorting
    $allowedSortFields = ['id', 'name', 'created_at', 'updated_at', 'is_active'];
    
    if (in_array($sortBy, $allowedSortFields)) {
        $query->orderBy($sortBy, $sortDirection === 'asc' ? 'asc' : 'desc');
    } else {
        $query->orderBy('created_at', 'desc');
    }
    
    return $query->paginate($perPage);
}
   
    public function create(array $data)
    {
        if (isset($data['parent_id']) && $data['parent_id']) {
            $parentCategory = $this->find($data['parent_id']);
            $data['level'] = $parentCategory->level + 1;
        } else {
            $data['level'] = 1; 
        }
        if (isset($data['photo'])) {
            $data['photo'] = $this->uploadPhoto($data['photo']);
        }
        return $this->model->create($data);
    }
    
    public function update(array $data, int $id)
    {
        $category = $this->find($id);
    
        if (isset($data['parent_id']) && $data['parent_id']) {
            $parentCategory = $this->find($data['parent_id']);
            $data['level'] = $parentCategory->level + 1;
        } else {
            $data['level'] = 1;
        }
        if (isset($data['photo'])) {
            if ($category->photo) {
                $this->deletePhoto($category->photo);
            }
            $data['photo'] = $this->uploadPhoto($data['photo']);
        }
        $category->update($data);
        return $category;
    }


protected function uploadPhoto($photo)
{
    $path = $photo->store('public/categories');
    return str_replace('public/', '', $path);
}

protected function deletePhoto($path)
{
    \Storage::delete('public/' . $path);
}
public function delete(int $id)
{
    return $this->model->destroy($id);
}
   
    public function find(int $id, array $columns = ['*'])
    {
        return $this->model->findOrFail($id, $columns);
    }
    
  
    public function findBy(string $column, string $value)
    {
        return $this->model->where($column, $value)->firstOrFail();
    }
   
    public function getActive()
    {
        return $this->model->where('is_active', true)->get();
    }
    
  
    public function getTree()
    {
        return $this->model->whereNull('parent_id')
                          ->with('children.children')
                          ->get();
    }
}